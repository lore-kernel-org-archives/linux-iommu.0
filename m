Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D22C433E0
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 15:44:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9053D2076D
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 15:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d28ardQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9053D2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 515CB203F4;
	Thu, 16 Jul 2020 15:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1uKOP4cwWQ-U; Thu, 16 Jul 2020 15:44:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E6D882010B;
	Thu, 16 Jul 2020 15:44:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE817C0893;
	Thu, 16 Jul 2020 15:44:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEBA7C0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 15:44:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C7A0C8AA9C
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 15:44:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZeMD-40sZrUJ for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 15:44:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7D9378AA97
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 15:44:34 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id o18so7040070eje.7
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8BWgho9X8RI/L7uqq87RuOGmaTQ9+9eUhrilsR9tGlI=;
 b=d28ardQKvFJmarWvEsjgf+bjDDqeSAeR2t9/81DFs5Z3wY2AA445PzgFW2dQq/sJ4z
 XwJ76vikBgP/nXRi5H6oq/UioOULK/x/p7FHNAoW5IH2Kvyk2snspiCuRIggSHYLS3xB
 k2M03DmBYR9qnE11aWbX54zXbFC8RmdABf847Gosr7OFHO0tkvmRYLRPrpY0qQps6Wyn
 kHrjdEuUBiXj7cIiaznBIxNOgIiuOBwWHmVMdAvVLzqj4WxrZpkYCJtQGm2jeRsFvGaX
 0/OgkxhOoSZJTp59JVpK6OnXDTuhQllxCXMVaaXHBy+KgLU5TWM/0LyVOPkxJjjTowwL
 W0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8BWgho9X8RI/L7uqq87RuOGmaTQ9+9eUhrilsR9tGlI=;
 b=lTQOS2uuRYYASHjnkcvdZ/1jX2sFxXEQLhh5N8n5+cPA0Ce83SFevpNETC+VcD595t
 HaYdlcWWwAq/xWL1tEtD4YlIK4T58ACgGkC2iMZTfXZxfJ1zaSOb9Cp42HvK5loNmHDA
 IZAWS/yMNedK5t2JHHo+5iPKiXzKDr18XhrY28CJDiFNeThNBoEpmeYNTGFfsc2iDFnp
 sJh9BjBe8cN7t8+eD9shmv1si7KSVWj4+kMAwp6KtFdxdWSRqyTvDO74xu9bTc4eepkQ
 yEGsghhkWMoVfW8ZTcX3dqYuOblZJMXo6UYGicEds8P5OMK1XtwJs1I8sQ+S3sss2zgj
 rR5g==
X-Gm-Message-State: AOAM532m0cNS2+XWzeKd9tQgiRlUhkCFat2AFw1he+jh+E+4xax4N2GA
 ntZCLcsjMBxFmFyIsoxiSfhBIA==
X-Google-Smtp-Source: ABdhPJyKchyYpHru9R2RC4M0KHCej+tNEWCy3+a11Z6w0U2Vk2alyMk6n19jyWhQrRj/sjitaPERUg==
X-Received: by 2002:a17:906:7c8:: with SMTP id
 m8mr4269928ejc.527.1594914272505; 
 Thu, 16 Jul 2020 08:44:32 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id di20sm5714804edb.26.2020.07.16.08.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 08:44:31 -0700 (PDT)
Date: Thu, 16 Jul 2020 17:44:19 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v8 04/12] arm64: mm: Pin down ASIDs for sharing mm with
 devices
Message-ID: <20200716154419.GB447208@myrica>
References: <20200618155125.1548969-1-jean-philippe@linaro.org>
 <20200618155125.1548969-5-jean-philippe@linaro.org>
 <20200713154622.GC3072@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200713154622.GC3072@willie-the-truck>
Cc: fenghua.yu@intel.com, catalin.marinas@arm.com, zhengxiang9@huawei.com,
 hch@infradead.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

Thanks for reviewing, I think these 3 or 4 patches are the trickiest in
the whole SVA series

On Mon, Jul 13, 2020 at 04:46:23PM +0100, Will Deacon wrote:
> On Thu, Jun 18, 2020 at 05:51:17PM +0200, Jean-Philippe Brucker wrote:
> > diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> > index 68140fdd89d6b..bbdd291e31d59 100644
> > --- a/arch/arm64/include/asm/mmu.h
> > +++ b/arch/arm64/include/asm/mmu.h
> > @@ -19,6 +19,7 @@
> >  
> >  typedef struct {
> >  	atomic64_t	id;
> > +	unsigned long	pinned;
> 
> bool?

It's a refcount. I'll change it to refcount_t because it looks nicer
overall, even though it doesn't need to be atomic.

> >  static void set_kpti_asid_bits(void)
> >  {
> > +	unsigned int k;
> > +	u8 *dst = (u8 *)asid_map;
> > +	u8 *src = (u8 *)pinned_asid_map;
> >  	unsigned int len = BITS_TO_LONGS(NUM_USER_ASIDS) * sizeof(unsigned long);
> >  	/*
> >  	 * In case of KPTI kernel/user ASIDs are allocated in
> > @@ -81,7 +88,8 @@ static void set_kpti_asid_bits(void)
> >  	 * is set, then the ASID will map only userspace. Thus
> >  	 * mark even as reserved for kernel.
> >  	 */
> > -	memset(asid_map, 0xaa, len);
> > +	for (k = 0; k < len; k++)
> > +		dst[k] = src[k] | 0xaa;
> 
> Can you use __bitmap_replace() here? I think it would be clearer to use the
> bitmap API wherever possible, since casting 'unsigned long *' to 'u8 *'
> just makes me worry about endianness issues (although in this case I don't
> hink it's a problem).

I can do better actually: initialize pinned_asid_map with the kernel ASID
bits at boot and just copy the bitmap on rollover.

> > +unsigned long mm_context_get(struct mm_struct *mm)
> > +{
> > +	unsigned long flags;
> > +	u64 asid;
> > +
> > +	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
> > +
> > +	asid = atomic64_read(&mm->context.id);
> > +
> > +	if (mm->context.pinned) {
> > +		mm->context.pinned++;
> > +		asid &= ~ASID_MASK;
> > +		goto out_unlock;
> > +	}
> > +
> > +	if (nr_pinned_asids >= max_pinned_asids) {
> > +		asid = 0;
> > +		goto out_unlock;
> > +	}
> > +
> > +	if (!asid_gen_match(asid)) {
> > +		/*
> > +		 * We went through one or more rollover since that ASID was
> > +		 * used. Ensure that it is still valid, or generate a new one.
> > +		 */
> > +		asid = new_context(mm);
> > +		atomic64_set(&mm->context.id, asid);
> > +	}
> > +
> > +	asid &= ~ASID_MASK;
> > +
> > +	nr_pinned_asids++;
> > +	__set_bit(asid2idx(asid), pinned_asid_map);
> > +	mm->context.pinned++;
> > +
> > +out_unlock:
> > +	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
> 
> Maybe stick the & ~ASID_MASK here so it's easier to read?
> 
> > +	/* Set the equivalent of USER_ASID_BIT */
> > +	if (asid && IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
> > +		asid |= 1;
> > +
> > +	return asid;
> > +}
> > +EXPORT_SYMBOL_GPL(mm_context_get);
> 
> That's quite a generic symbol name to export... maybe throw 'arm64_' in
> front of it?
> 
> > +
> > +void mm_context_put(struct mm_struct *mm)
> > +{
> > +	unsigned long flags;
> > +	u64 asid = atomic64_read(&mm->context.id) & ~ASID_MASK;
> 
> I don't think you need the masking here.

Right, asid2idx() takes care of it.

> 
> > +	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
> > +
> > +	if (--mm->context.pinned == 0) {
> > +		__clear_bit(asid2idx(asid), pinned_asid_map);
> > +		nr_pinned_asids--;
> > +	}
> > +
> > +	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(mm_context_put);
> 
> Same naming comment here.
> 
> >  /* Errata workaround post TTBRx_EL1 update. */
> >  asmlinkage void post_ttbr_update_workaround(void)
> >  {
> > @@ -303,6 +381,13 @@ static int asids_update_limit(void)
> >  	WARN_ON(num_available_asids - 1 <= num_possible_cpus());
> >  	pr_info("ASID allocator initialised with %lu entries\n",
> >  		num_available_asids);
> > +
> > +	/*
> > +	 * We assume that an ASID is always available after a rollover. This
> > +	 * means that even if all CPUs have a reserved ASID, there still is at
> > +	 * least one slot available in the asid map.
> > +	 */
> > +	max_pinned_asids = num_available_asids - num_possible_cpus() - 2;
> 
> Is it worth checking that assumption, rather than setting max_pinned_asids
> to a massive value?

The comment isn't right, it should be something like:

	"There must always be an ASID available after a rollover. Ensure
	that, even if all CPUs have a reserved ASID and the maximum number
	of ASIDs are pinned, there still is at least one empty slot in the
	ASID map."

I do wonder if we should reduce max_pinned_asids, because the system will
probably become unusable if it gets close to a single available ASID.  But
I think we'll need to introduce higher-level controls for SVA such as
cgroups to prevent users from pinning too many ASIDs.

> 
> >  	return 0;
> >  }
> >  arch_initcall(asids_update_limit);
> > @@ -317,6 +402,12 @@ static int asids_init(void)
> >  		panic("Failed to allocate bitmap for %lu ASIDs\n",
> >  		      NUM_USER_ASIDS);
> >  
> > +	pinned_asid_map = kcalloc(BITS_TO_LONGS(NUM_USER_ASIDS),
> > +				  sizeof(*pinned_asid_map), GFP_KERNEL);
> > +	if (!pinned_asid_map)
> > +		panic("Failed to allocate pinned ASID bitmap\n");
> 
> Why can't we continue in this case without support for pinned ASIDs?

Good idea, I'll change that

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
