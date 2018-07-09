From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
	AMD sme enabled
Date: Mon, 9 Jul 2018 11:29:01 +0200
Message-ID: <20180709092901.GA22182@nazgul.tnic>
References: <20180702072639.10110-1-lijiang@redhat.com>
	<20180702072639.10110-2-lijiang@redhat.com>
	<20180702101451.GB28730@zn.tnic>
	<4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
	<895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
	<20180703111428.GB5748@zn.tnic>
	<4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
	<e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e7357038-08bd-7ba8-5357-7c91d21d10fe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: lijiang <lijiang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: thomas.lendacky-5C7GfCeVMHo@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 09, 2018 at 02:28:11PM +0800, lijiang wrote:
> Last week, I had tried many ways to do this work, but it looks
> like that the ways of deducing address is not suitable to another
> scenarios, such as mapping some devices mmio space, which are
> unencrypted, and the device mmio space is outside kdump kernel like
> the old memory, but the old memory is encrypted, we can't find the
> general rules to decide when to encrypt or not.

If we can't find the "general rules" how is the caller supposed to know
how to access the memory?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
