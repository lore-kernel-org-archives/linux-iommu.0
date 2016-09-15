From: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Don't put completion-wait semaphore on stack
Date: Thu, 15 Sep 2016 07:44:35 +0200
Message-ID: <20160915054435.GA25155@gmail.com>
References: <1473846119-9527-1-git-send-email-joro@8bytes.org>
	<20160914152647.GA13814@gmail.com>
	<20160914212712.GD1437@8bytes.org> <20160914213835.GA28800@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160914213835.GA28800-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


* Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org> wrote:

> On Wed, Sep 14, 2016 at 11:27:12PM +0200, Joerg Roedel wrote:
> > On Wed, Sep 14, 2016 at 05:26:48PM +0200, Ingo Molnar wrote:
> > > 
> > > Cool, thanks! I'll put this into tip:x86/asm which has the virtually mapped stack 
> > > patches - ok?
> > 
> > Yeah, sure, that is the best thing to do. Just wait for the v2 I'll
> > sending tomorrow. I just realised that the locking is not correct in one
> > of the cases with this patch and I'd like to fix that first.
> 
> Oh sorry, just saw the tip-bot mail. Let me know whether you can still
> remove it and just take v2 or if you want a follow-on patch.

Yeah, I can still remove it - just zapped it in fact.

Thanks,

	Ingo
