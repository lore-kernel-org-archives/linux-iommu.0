From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: VT-d and x2apic: broken resume after suspend to ram
Date: Fri, 1 Nov 2013 14:07:10 +0100
Message-ID: <20131101130702.GA3348@8bytes.org>
References: <CA+MoWDqoBxuFhBsf_rVBT1C8=mwj02hXgPfuWnjY4yeVa-84cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+MoWDqoBxuFhBsf_rVBT1C8=mwj02hXgPfuWnjY4yeVa-84cA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peter Senna Tschudin <peter.senna-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Seiji Aguchi <seiji.aguchi-7rDLJAbr9SE@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Peter,

On Fri, Nov 01, 2013 at 01:37:36PM +0100, Peter Senna Tschudin wrote:
> I have one notebook that is failing to resume after suspend to ram.
> I've filled a bug report back on the 2.6.41 days:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=787299
> 
> The issue is that trying to resume after suspending to ram freezes the
> computer. The resume starts well, but then it hangs.
> 
> Yesterday I found that this may be related to VT-d / x2apic. If I
> disable VT-d on the BIOS, suspend / resume works fine. If I enable
> VT-d and pass nox2apic as boot parameter to Kernel suspend and resume
> works fine. I would like some pointers to fix this issue. Can you help
> me?
> 
> Only when I have VT-d enabled, dmesg gives me additional output:
> [    0.023913] IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
> [    0.024080] Enabled IRQ remapping in x2apic mode
> [    0.024081] Enabling x2apic
> [    0.024082] Enabled x2apic
> [    0.024087] Switched APIC routing to cluster x2apic.
> 
> The notebook is Toshiba R830-10p with i7-2620M.

Which kernels have you tried? Does it happen with all of them or is
there a kernel-version where this started?


	Joerg
