From: Michael Wang <yun.wang-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for
	kmemleak
Date: Wed, 2 Dec 2015 15:09:18 +0100
Message-ID: <565EFB8E.4020600@profitbricks.com>
References: <CAHkRjk5WzPT1gRaa=3qyrp1gcee9ZQKF_rU42FAu0C6ep8JPug@mail.gmail.com>
	<565ED81B.3020606@profitbricks.com> <20151202115142.GD18805@8bytes.org>
	<565EE4AA.4070309@profitbricks.com> <20151202125315.GB3910@pd.tnic>
	<565EEBC3.5050807@profitbricks.com> <20151202131300.GC3910@pd.tnic>
	<565EEFB4.4080108@profitbricks.com> <20151202134047.GE3783@pd.tnic>
	<565EF6BF.6020204@profitbricks.com> <20151202135931.GF3783@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151202135931.GF3783-fF5Pk5pvG8Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Catalin Marinas <catalin.marinas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 12/02/2015 02:59 PM, Borislav Petkov wrote:
> On Wed, Dec 02, 2015 at 02:48:47PM +0100, Michael Wang wrote:
>> I'm not sure why amd-iommu use get_page not kmalloc to initialize the
>> pointer table, but if it's necessary then the conflict will be there,
>> it's not the fault of driver or kmemleak, but the design require them
>> to cooperate with each other.
> 
> So, according to you, we should go and "fix" all callers of
> __get_free_pages() to make kmemleak happy. Then when the next new tool
> comes along, we should "fix" another kernel API just so that the tools
> are happy.

That's the way we have to detect leak, no driver could get rid of
the possibility of memory leaking, so it should respect the rule to
help others locating the problem, if a driver full of false report then
most likely folks will gradually lost interests on help fix leaking
problem for it.

> 
> Bzzt. Wrong!
> 
> The tools should work without sprinkling their code everywhere. Driver
> etc developers don't need to care about what tool they make happy or
> not. Tools' hooks should be hidden in macro magic so that developers
> don't care.

This tool will help improve the kernel, AFAIK it's already made it's
best, if you got any idea on how to make it even better that would be
great, but at this moment, it still need few of care :-P

Regards,
Michael Wang

> 
