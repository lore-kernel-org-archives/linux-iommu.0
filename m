Return-Path: <SRS0=F2nw=MY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2585EC4338F
	for <iommu@archiver.kernel.org>; Sun,  1 Aug 2021 06:19:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF6161059
	for <iommu@archiver.kernel.org>; Sun,  1 Aug 2021 06:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AFF6161059
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7772683C8E;
	Sun,  1 Aug 2021 06:19:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JlOr28eSzFgN; Sun,  1 Aug 2021 06:19:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7BD4D838AC;
	Sun,  1 Aug 2021 06:19:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35AACC0010;
	Sun,  1 Aug 2021 06:19:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D259EC0010
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 22:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ADBBA40236
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 22:34:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zJIyY8DWuHV2 for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 22:34:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A14C940228
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 22:34:42 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 ds11-20020a17090b08cbb0290172f971883bso22887796pjb.1
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2B8bmMK1MWV0IKBzZFhJ4QQnRCCDWLQwwtmcrrRzShw=;
 b=UfW+Uyhy937lSOvlfCbvzUSHfPBdVvhcTOaILHqlmzjEQeZkE7CJS1pDjY85yLeTrk
 ZUbJvCXGnG9V4YR8YvLqiCoHxoAuC0RJHo8xznM5u3dhr6dkJI9BNq9mI/HgcDxL19UV
 T0+Bsg6O2a3etVDRUOMu6je3JU33B5pFqiYpolqwzc84ASrmmPyryuwH24+FPODl2NK0
 /jswqbw3cLYGC3s8tw+3+64iNj05CofMOCHjsjPmhNsSGF6fZGX5s2X6UpkAmOT82yEf
 KD+vMh5N6wzurqnoLV7GP3bDuQRiamzrkbH5J6wxueQVfjy9YKlsV1lqKUCTBLbTMy1G
 tbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2B8bmMK1MWV0IKBzZFhJ4QQnRCCDWLQwwtmcrrRzShw=;
 b=JIuY9I/N3p3XnNTOGvQd4MgMDlMw0rEodhYAH9Bu+uKZDNPB0VffMCbXihNueY91/k
 9VFabS7q/kxlWbdxiEmtxJAO7wQWVTiUNbgR6KrPnSZsH6SaObFeNPLC5FiIuXaapaD4
 euXswFEj9kcVmBIdRQ8vor+JdZMOjLPSLyT7fOLJ0H+cKIq3unVFQmYamPwCFI5iO5Bl
 QA+6tBc5k9A7pXjJBFW/prXhjKqt/2ARhe+6iz86g5zdccdhcOkB3pkaYBSmEkM8pUtY
 aIR6yAuMk5UWy1mxqbfqtJTUkH6ozp9ZsEuCtXZzTqFjAHS8FUqbBhO6XHXrqd0yxB8/
 WwbA==
X-Gm-Message-State: AOAM532qdaORahdN1+XIS1KpwP6OzCG8Vwz2/iefltcpi29KrEOP9nVd
 4LsuMHY8/UbwbyAHvHnZWRkA2A==
X-Google-Smtp-Source: ABdhPJzSqN3B7Go3MtNjE9VY5h0clk+hYXj3ladZ5/S+PnXE8W92M9c05HKB4nGF1ekuX4eoULgjrQ==
X-Received: by 2002:a17:90b:1bcc:: with SMTP id
 oa12mr5239612pjb.113.1627684481796; 
 Fri, 30 Jul 2021 15:34:41 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com.
 [35.185.214.157])
 by smtp.gmail.com with ESMTPSA id b184sm3525033pfg.72.2021.07.30.15.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jul 2021 15:34:41 -0700 (PDT)
Date: Fri, 30 Jul 2021 22:34:37 +0000
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
Message-ID: <YQR+ffO92gMfGDbs@google.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
X-Mailman-Approved-At: Sun, 01 Aug 2021 06:19:22 +0000
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Ingo Molnar <mingo@redhat.com>, linux-graphics-maintainer@vmware.com,
 Dave Young <dyoung@redhat.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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
From: Sean Christopherson via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Jul 27, 2021, Tom Lendacky wrote:
> @@ -451,7 +450,7 @@ void __init mem_encrypt_free_decrypted_mem(void)
>  	 * The unused memory range was mapped decrypted, change the encryption
>  	 * attribute from decrypted to encrypted before freeing it.
>  	 */
> -	if (mem_encrypt_active()) {
> +	if (sme_me_mask) {

Any reason this uses sme_me_mask?  The helper it calls, __set_memory_enc_dec(),
uses prot_guest_has(PATTR_MEM_ENCRYPT) so I assume it's available?

>  		r = set_memory_encrypted(vaddr, npages);
>  		if (r) {
>  			pr_warn("failed to free unused decrypted pages\n");

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
