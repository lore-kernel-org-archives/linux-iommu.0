From: Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Fix shift overflow in qi_flush_dev_iotlb
Date: Fri, 15 Dec 2017 15:29:57 +0800
Message-ID: <20171215072957.GJ7780@xz-mi>
References: <20171212224250.22173.74201.stgit@gimli.home>
	<20171213071355.GD7780@xz-mi> <20171213085847.3d3245c6@t450s.home>
	<ae778a81-a500-d8d2-5c7e-10630fe42734@amd.com>
	<20171213101518.7807ae4b@t450s.home>
	<b8d7c8fd-8370-a0f0-e5db-f211423d7b9b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b8d7c8fd-8370-a0f0-e5db-f211423d7b9b-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Hook, Gary" <ghook-5C7GfCeVMHo@public.gmane.org>
Cc: tursulin-9sj9WOxYP5jR7s880joybQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 13, 2017 at 11:31:02AM -0600, Hook, Gary wrote:
> On 12/13/2017 11:15 AM, Alex Williamson wrote:
> > On Wed, 13 Dec 2017 10:41:47 -0600
> > "Hook, Gary" <ghook-5C7GfCeVMHo@public.gmane.org> wrote:
> > 
> > > On 12/13/2017 9:58 AM, Alex Williamson wrote:
> > > > On Wed, 13 Dec 2017 15:13:55 +0800
> > > > Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > > > > On Tue, Dec 12, 2017 at 03:43:08PM -0700, Alex Williamson wrote:
> > > > > 
> > > > > [...]
> > > > > > diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> > > > > > index 9a7ffd13c7f0..87888b102057 100644
> > > > > > --- a/drivers/iommu/dmar.c
> > > > > > +++ b/drivers/iommu/dmar.c
> > > > > > @@ -1345,7 +1345,9 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
> > > > > >    	struct qi_desc desc;
> > > > > >    	if (mask) {
> > > > > > -		BUG_ON(addr & ((1 << (VTD_PAGE_SHIFT + mask)) - 1));
> > > > > > +		BUG_ON((mask > MAX_AGAW_PFN_WIDTH) ||
> > > > > > +		       ((mask == MAX_AGAW_PFN_WIDTH) && addr) ||
> > > > > > +		       (addr & ((1 << (VTD_PAGE_SHIFT + mask)) - 1)));
> > > > > 
> > > > > Could it work if we just use 1ULL instead of 1 here?  Thanks,
> > > > 
> > > > In either case we're talking about shifting off the end of the
> > > > variable, which I understand to be undefined.  Right?  Thanks,
> > > 
> > > How so? Bits fall off the left (MSB) end, zeroes fill in the right (LSB)
> > > end. I believe that behavior is pretty set.
> > 
> > Maybe I'm relying too much on stackoverflow, but:
> > 
> > https://stackoverflow.com/questions/11270492/what-does-the-c-standard-say-about-bitshifting-more-bits-than-the-width-of-type
> 
> No, probably not. I don't have my copy of c99 handy, so can't check it. But
> it is beyond me why any compiler implementation would choose to use a rotate
> instead of a shift... probably a performance issue.
> 
> So, yeah, when you have silly parameters, you get what you get.
> 
> I'll stick to my suggestion. Which seems unambiguous... but I could be
> wrong.

Hi, Alex, Hook,

I did a quick test:

xz-mi:tmp $ cat a.c
#include <stdio.h>

void main(void)
{
    unsigned long long val = 0x8000000000000001ULL;
    int shift; 

    printf("origin: 0x%llx\n", val);
    shift = 1; printf("shl 1: 0x%llx\n", val << shift);
    shift = 62; printf("shl 62: 0x%llx\n", val << shift);
    shift = 63; printf("shl 63: 0x%llx\n", val << shift);
    shift = 64; printf("shl 64: 0x%llx\n", val << shift);
    shift = 65; printf("shl 65: 0x%llx\n", val << shift);
}
xz-mi:tmp $ gcc -std=c99 a.c
xz-mi:tmp $ ./a.out 
origin: 0x8000000000000001
shl 1: 0x2
shl 62: 0x4000000000000000
shl 63: 0x8000000000000000
shl 64: 0x8000000000000001
shl 65: 0x2
xz-mi:tmp $ objdump -d a.out | grep -A20 "<main>"
00000000004004d7 <main>:
  4004d7:       55                      push   %rbp
  4004d8:       48 89 e5                mov    %rsp,%rbp
  4004db:       48 83 ec 10             sub    $0x10,%rsp
  4004df:       48 b8 01 00 00 00 00    movabs $0x8000000000000001,%rax
  4004e6:       00 00 80 
  4004e9:       48 89 45 f8             mov    %rax,-0x8(%rbp)
  4004ed:       48 8b 45 f8             mov    -0x8(%rbp),%rax
  4004f1:       48 89 c6                mov    %rax,%rsi
  4004f4:       bf 60 06 40 00          mov    $0x400660,%edi
  4004f9:       b8 00 00 00 00          mov    $0x0,%eax
  4004fe:       e8 ed fe ff ff          callq  4003f0 <printf@plt>
  400503:       c7 45 f4 01 00 00 00    movl   $0x1,-0xc(%rbp)
  40050a:       8b 45 f4                mov    -0xc(%rbp),%eax
  40050d:       48 8b 55 f8             mov    -0x8(%rbp),%rdx
  400511:       89 c1                   mov    %eax,%ecx
  400513:       48 d3 e2                shl    %cl,%rdx
  400516:       48 89 d0                mov    %rdx,%rax
  400519:       48 89 c6                mov    %rax,%rsi
  40051c:       bf 70 06 40 00          mov    $0x400670,%edi
  400521:       b8 00 00 00 00          mov    $0x0,%eax

So it seems not really a rotation operation, but it looks more like
convering a "shifting N" into "shifting N%64" when N>=64.  So now I
agree with Alex's change.  Thanks all.

-- 
Peter Xu
