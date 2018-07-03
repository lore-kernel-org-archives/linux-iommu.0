From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
	AMD sme enabled
Date: Tue, 3 Jul 2018 11:39:24 +0200
Message-ID: <20180703093924.GA5748@zn.tnic>
References: <20180702072639.10110-1-lijiang@redhat.com>
	<20180702072639.10110-2-lijiang@redhat.com>
	<20180702101451.GB28730@zn.tnic>
	<4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4ae1cfb5-0a4b-2aac-2575-024e2c74826f-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

On Tue, Jul 03, 2018 at 10:17:19AM +0800, lijiang wrote:
> for example, the elfcorehdr. In fact, the elfcorehdr and notes

You mean this?

 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-       return read_from_oldmem(buf, count, ppos, 0);
+       return read_from_oldmem(buf, count, ppos, 0, sme_active());

That looks encrypted to me.

> call the same function(read_from_oldmem->ioremap_cache), in this case,
> it is very difficult to properly remap the memory if the caller don't
> care whether the memory is encrypted.

So beef up the logic in __ioremap_caller() to figure out based on the
address whether to access the memory encrypted or not. You can find out
the elfcorehdr address in the capture kernel.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
