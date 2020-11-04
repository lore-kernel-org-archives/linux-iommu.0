Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD79C2D0A3
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 22:16:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66B42080D
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 22:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRiUQwHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66B42080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 829F1854DB;
	Wed,  4 Nov 2020 22:16:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dUoq1Vt_1BTz; Wed,  4 Nov 2020 22:16:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 61BAC854AD;
	Wed,  4 Nov 2020 22:16:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49F84C088B;
	Wed,  4 Nov 2020 22:16:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E0F6C0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 22:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7BD2C87115
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 22:16:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8z7gkGuq4KcU for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 22:16:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6460987111
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 22:16:38 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id o129so18510060pfb.1
 for <iommu@lists.linux-foundation.org>; Wed, 04 Nov 2020 14:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=134Ljw+dlZxlDyNcjhHB7MEA0AqdM9RhLNcuPviUlT0=;
 b=YRiUQwHNqE8N7rXO36vbvj78kZZQf9KxwycyxYjRbMJoLItppzHkSjiKF32coqlWPk
 0/5HOaa2jVPfWlz6LRfr9Lco/zMsdvVvEJL7hHz8weh77uRkoWQ9AkTdd4mzSXRpw0Mn
 bpwZz55+10lQZNsd6fVrPJLk4Wtl/NInliJssWjoFPA3nCxoa8CjjWk0bmXT90tve0S0
 wigAIE2XNzA588wBjua9n8qeN+Z151FVeXtubyc1KSIWydosK6s900OqJ6OK5qHxnJ+S
 EuuaDLdV5l3XfhrEmImWdk8jWVqR2q141odMIpkenP20hEeggsWT9IjPI7eEH0/0svmd
 Y5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=134Ljw+dlZxlDyNcjhHB7MEA0AqdM9RhLNcuPviUlT0=;
 b=EnMWcmuLcToMI2WehKzL2XAOTmXUoop1gI+Htkcwg98kkVUveRlGxDtMdjIKg4U5Gs
 lJMTauLgKpvkZJR8BCzZ+fD7g0lQKBh9cLlgi+RWjieoZj8qtgQbDkv/4Zt4AqjA9Y2a
 +SzFgLvpvZQ5yvrQ9LWWQQjZ5bkzy/is2ie79WPOkS/uD7RioOBeATuKVIihsaotunKh
 vjcslPAM88ZcjH/24f188qm3jAyGug2ZlQsoKJkxzGFkrdJy/897w4xjLHjSzs33XNGe
 g7SGcb3dUkCGoxDxf42e07wbysVKAGiCZ3Sod/MSbBoUJs6GX+cFTbNEg4whO5Kw+B2c
 8Ciw==
X-Gm-Message-State: AOAM532ea4DciO9q6wlNeWEljdApogZkD/0GqmWyVU5+imiY5zPnuR+F
 lmqU8TAmVi4vYGZ7gY/rInD5ejgQb/DdLTfswFg=
X-Google-Smtp-Source: ABdhPJyE0iFLxttOHPTqoPWwXyizOt0DW0oe0O2hDjemAbrrjKFaPKY8J4ni9G973OAvGXvdP0uAIcV57+gkM/bvAcA=
X-Received: by 2002:a17:90b:3446:: with SMTP id
 lj6mr45685pjb.228.1604528197894; 
 Wed, 04 Nov 2020 14:16:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:90a:f6c8:0:0:0:0 with HTTP; Wed, 4 Nov 2020 14:16:37
 -0800 (PST)
In-Reply-To: <20201104220804.21026-1-Ashish.Kalra@amd.com>
References: <20201104220804.21026-1-Ashish.Kalra@amd.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Nov 2020 00:16:37 +0200
Message-ID: <CAHp75VeiZd+TKptkQ5oxENLfiKOUBs4Fw6rMKuNtCn2AoM7jYg@mail.gmail.com>
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: "Thomas.Lendacky@amd.com" <Thomas.Lendacky@amd.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "ssg.sos.patches@amd.com" <ssg.sos.patches@amd.com>,
 "dave.hansen@linux-intel.com" <dave.hansen@linux-intel.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "luto@kernel.org" <luto@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "hch@lst.de" <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6154157534212112082=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============6154157534212112082==
Content-Type: multipart/alternative; boundary="00000000000044860105b34f557a"

--00000000000044860105b34f557a
Content-Type: text/plain; charset="UTF-8"

On Thursday, November 5, 2020, Ashish Kalra <Ashish.Kalra@amd.com> wrote:

> From: Ashish Kalra <ashish.kalra@amd.com>
>
> For SEV, all DMA to and from guest has to use shared
> (un-encrypted) pages. SEV uses SWIOTLB to make this
> happen without requiring changes to device drivers.
> However, depending on workload being run, the default
> 64MB of SWIOTLB might not be enough and SWIOTLB
> may run out of buffers to use for DMA, resulting
> in I/O errors and/or performance degradation for
> high I/O workloads.
>
> Increase the default size of SWIOTLB for SEV guests
> using a minimum value of 128MB and a maximum value
> of 512MB, determining on amount of provisioned guest
> memory.
>
> Using late_initcall() interface to invoke
> swiotlb_adjust() does not work as the size
> adjustment needs to be done before mem_encrypt_init()
> and reserve_crashkernel() which use the allocated
> SWIOTLB buffer size, hence calling it explicitly
> from setup_arch().
>
> The SWIOTLB default size adjustment is added as an
> architecture specific interface/callback to allow
> architectures such as those supporting memory
> encryption to adjust/expand SWIOTLB size for their
> use.
>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/kernel/setup.c   |  2 ++
>  arch/x86/mm/mem_encrypt.c | 42 +++++++++++++++++++++++++++++++++++++++
>  include/linux/swiotlb.h   |  1 +
>  kernel/dma/swiotlb.c      | 27 +++++++++++++++++++++++++
>  4 files changed, 72 insertions(+)
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3511736fbc74..b073d58dd4a3 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1166,6 +1166,8 @@ void __init setup_arch(char **cmdline_p)
>         if (boot_cpu_has(X86_FEATURE_GBPAGES))
>                 hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
>
> +       swiotlb_adjust();
> +
>         /*
>          * Reserve memory for crash kernel after SRAT is parsed so that it
>          * won't consume hotpluggable memory.
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 3f248f0d0e07..e0deb157cddd 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -489,7 +489,49 @@ static void print_mem_encrypt_feature_info(void)
>         pr_cont("\n");
>  }
>
> +#define TOTAL_MEM_1G   0x40000000UL
> +#define TOTAL_MEM_4G   0x100000000UL
> +
> +#define SIZE_128M (128UL<<20)
> +#define SIZE_256M (256UL<<20)
> +#define SIZE_512M (512UL<<20)



We have these constants defined in sizes.h.


> +
>  /* Architecture __weak replacement functions */
> +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> +{
> +       unsigned long size = 0;
> +
> +       /*
> +        * For SEV, all DMA has to occur via shared/unencrypted pages.
> +        * SEV uses SWOTLB to make this happen without changing device
> +        * drivers. However, depending on the workload being run, the
> +        * default 64MB of SWIOTLB may not be enough & SWIOTLB may
> +        * run out of buffers for DMA, resulting in I/O errors and/or
> +        * performance degradation especially with high I/O workloads.
> +        * Increase the default size of SWIOTLB for SEV guests using
> +        * a minimum value of 128MB and a maximum value of 512MB,
> +        * depending on amount of provisioned guest memory.
> +        */
> +       if (sev_active()) {
> +               phys_addr_t total_mem = memblock_phys_mem_size();
> +
> +               if (total_mem <= TOTAL_MEM_1G)
> +                       size = clamp(iotlb_default_size * 2, SIZE_128M,
> +                                    SIZE_128M);
> +               else if (total_mem <= TOTAL_MEM_4G)
> +                       size = clamp(iotlb_default_size * 4, SIZE_256M,
> +                                    SIZE_256M);
> +               else
> +                       size = clamp(iotlb_default_size * 8, SIZE_512M,
> +                                    SIZE_512M);
> +
> +               pr_info("SEV adjusted max SWIOTLB size = %luMB",
> +                       size >> 20);
> +       }
> +
> +       return size;
> +}
> +
>  void __init mem_encrypt_init(void)
>  {
>         if (!sme_me_mask)
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 046bb94bd4d6..01ae6d891327 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -33,6 +33,7 @@ extern void swiotlb_init(int verbose);
>  int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
>  extern unsigned long swiotlb_nr_tbl(void);
>  unsigned long swiotlb_size_or_default(void);
> +extern void __init swiotlb_adjust(void);
>  extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
>  extern void __init swiotlb_update_mem_attributes(void);
>
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c19379fabd20..66a9e627bb51 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -163,6 +163,33 @@ unsigned long swiotlb_size_or_default(void)
>         return size ? size : (IO_TLB_DEFAULT_SIZE);
>  }
>
> +unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)
> +{
> +       return 0;
> +}
> +
> +void __init swiotlb_adjust(void)
> +{
> +       unsigned long size;
> +
> +       /*
> +        * If swiotlb parameter has not been specified, give a chance to
> +        * architectures such as those supporting memory encryption to
> +        * adjust/expand SWIOTLB size for their use.
> +        */
> +       if (!io_tlb_nslabs) {
> +               size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
> +               if (size) {
> +                       size = ALIGN(size, 1 << IO_TLB_SHIFT);
> +                       io_tlb_nslabs = size >> IO_TLB_SHIFT;
> +                       io_tlb_nslabs = ALIGN(io_tlb_nslabs,
> IO_TLB_SEGSIZE);
> +
> +                       pr_info("architecture adjusted SWIOTLB slabs =
> %lu\n",
> +                               io_tlb_nslabs);
> +               }
> +       }
> +}
> +
>  void swiotlb_print_info(void)
>  {
>         unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> --
> 2.17.1
>
>

-- 
With Best Regards,
Andy Shevchenko

--00000000000044860105b34f557a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, November 5, 2020, Ashish Kalra &lt;<a href=3D"mailto:A=
shish.Kalra@amd.com">Ashish.Kalra@amd.com</a>&gt; wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">From: Ashish Kalra &lt;<a href=3D"mailto:ashish.kalra@amd.c=
om">ashish.kalra@amd.com</a>&gt;<br>
<br>
For SEV, all DMA to and from guest has to use shared<br>
(un-encrypted) pages. SEV uses SWIOTLB to make this<br>
happen without requiring changes to device drivers.<br>
However, depending on workload being run, the default<br>
64MB of SWIOTLB might not be enough and SWIOTLB<br>
may run out of buffers to use for DMA, resulting<br>
in I/O errors and/or performance degradation for<br>
high I/O workloads.<br>
<br>
Increase the default size of SWIOTLB for SEV guests<br>
using a minimum value of 128MB and a maximum value<br>
of 512MB, determining on amount of provisioned guest<br>
memory.<br>
<br>
Using late_initcall() interface to invoke<br>
swiotlb_adjust() does not work as the size<br>
adjustment needs to be done before mem_encrypt_init()<br>
and reserve_crashkernel() which use the allocated<br>
SWIOTLB buffer size, hence calling it explicitly<br>
from setup_arch().<br>
<br>
The SWIOTLB default size adjustment is added as an<br>
architecture specific interface/callback to allow<br>
architectures such as those supporting memory<br>
encryption to adjust/expand SWIOTLB size for their<br>
use.<br>
<br>
Signed-off-by: Ashish Kalra &lt;<a href=3D"mailto:ashish.kalra@amd.com">ash=
ish.kalra@amd.com</a>&gt;<br>
---<br>
=C2=A0arch/x86/kernel/setup.c=C2=A0 =C2=A0|=C2=A0 2 ++<br>
=C2=A0arch/x86/mm/mem_encrypt.c | 42 ++++++++++++++++++++++++++++++<wbr>+++=
++++++<br>
=C2=A0include/linux/swiotlb.h=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0kernel/dma/swiotlb.c=C2=A0 =C2=A0 =C2=A0 | 27 +++++++++++++++++++++++=
++<br>
=C2=A04 files changed, 72 insertions(+)<br>
<br>
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c<br>
index 3511736fbc74..b073d58dd4a3 100644<br>
--- a/arch/x86/kernel/setup.c<br>
+++ b/arch/x86/kernel/setup.c<br>
@@ -1166,6 +1166,8 @@ void __init setup_arch(char **cmdline_p)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (boot_cpu_has(X86_FEATURE_<wbr>GBPAGES))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hugetlb_cma_reserve=
(PUD_SHIFT - PAGE_SHIFT);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0swiotlb_adjust();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Reserve memory for crash kernel after S=
RAT is parsed so that it<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* won&#39;t consume hotpluggable memory.<=
br>
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c<br>
index 3f248f0d0e07..e0deb157cddd 100644<br>
--- a/arch/x86/mm/mem_encrypt.c<br>
+++ b/arch/x86/mm/mem_encrypt.c<br>
@@ -489,7 +489,49 @@ static void print_mem_encrypt_feature_<wbr>info(void)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_cont(&quot;\n&quot;);<br>
=C2=A0}<br>
<br>
+#define TOTAL_MEM_1G=C2=A0 =C2=A00x40000000UL<br>
+#define TOTAL_MEM_4G=C2=A0 =C2=A00x100000000UL<br>
+<br>
+#define SIZE_128M (128UL&lt;&lt;20)<br>
+#define SIZE_256M (256UL&lt;&lt;20)<br>
+#define SIZE_512M (512UL&lt;&lt;20)</blockquote><div><br></div><div><br></=
div><div>We have these constants defined in sizes.h.</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+<br>
=C2=A0/* Architecture __weak replacement functions */<br>
+unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)=
<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long size =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * For SEV, all DMA has to occur via shared/une=
ncrypted pages.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * SEV uses SWOTLB to make this happen without =
changing device<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * drivers. However, depending on the workload =
being run, the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * default 64MB of SWIOTLB may not be enough &a=
mp; SWIOTLB may<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * run out of buffers for DMA, resulting in I/O=
 errors and/or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * performance degradation especially with high=
 I/O workloads.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Increase the default size of SWIOTLB for SEV=
 guests using<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * a minimum value of 128MB and a maximum value=
 of 512MB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * depending on amount of provisioned guest mem=
ory.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (sev_active()) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t total_m=
em =3D memblock_phys_mem_size();<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (total_mem &lt;=
=3D TOTAL_MEM_1G)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0size =3D clamp(iotlb_default_size * 2, SIZE_128M,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SIZE_128M);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (total_mem =
&lt;=3D TOTAL_MEM_4G)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0size =3D clamp(iotlb_default_size * 4, SIZE_256M,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SIZE_256M);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0size =3D clamp(iotlb_default_size * 8, SIZE_512M,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SIZE_512M);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_info(&quot;SEV a=
djusted max SWIOTLB size =3D %luMB&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0size &gt;&gt; 20);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return size;<br>
+}<br>
+<br>
=C2=A0void __init mem_encrypt_init(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!sme_me_mask)<br>
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h<br>
index 046bb94bd4d6..01ae6d891327 100644<br>
--- a/include/linux/swiotlb.h<br>
+++ b/include/linux/swiotlb.h<br>
@@ -33,6 +33,7 @@ extern void swiotlb_init(int verbose);<br>
=C2=A0int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbos=
e);<br>
=C2=A0extern unsigned long swiotlb_nr_tbl(void);<br>
=C2=A0unsigned long swiotlb_size_or_default(void);<br>
+extern void __init swiotlb_adjust(void);<br>
=C2=A0extern int swiotlb_late_init_with_tbl(<wbr>char *tlb, unsigned long n=
slabs);<br>
=C2=A0extern void __init swiotlb_update_mem_attributes(<wbr>void);<br>
<br>
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c<br>
index c19379fabd20..66a9e627bb51 100644<br>
--- a/kernel/dma/swiotlb.c<br>
+++ b/kernel/dma/swiotlb.c<br>
@@ -163,6 +163,33 @@ unsigned long swiotlb_size_or_default(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return size ? size : (IO_TLB_DEFAULT_SIZE);<br>
=C2=A0}<br>
<br>
+unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+void __init swiotlb_adjust(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long size;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If swiotlb parameter has not been specified,=
 give a chance to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * architectures such as those supporting memor=
y encryption to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * adjust/expand SWIOTLB size for their use.<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!io_tlb_nslabs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D arch_swiot=
lb_adjust(IO_TLB_<wbr>DEFAULT_SIZE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0size =3D ALIGN(size, 1 &lt;&lt; IO_TLB_SHIFT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0io_tlb_nslabs =3D size &gt;&gt; IO_TLB_SHIFT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0io_tlb_nslabs =3D ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pr_info(&quot;architecture adjusted SWIOTLB slabs =3D %lu\n&quot;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0io_tlb_nslabs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
=C2=A0void swiotlb_print_info(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long bytes =3D io_tlb_nslabs &lt;&lt; =
IO_TLB_SHIFT;<br>
-- <br>
2.17.1<br>
<br>
</blockquote><br><br>-- <br>With Best Regards,<br>Andy Shevchenko<br><br><b=
r>

--00000000000044860105b34f557a--

--===============6154157534212112082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6154157534212112082==--
