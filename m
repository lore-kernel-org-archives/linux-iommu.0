Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F9EC433F5
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 02:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E3FE740B4D;
	Tue, 17 May 2022 02:05:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sAtDDNrtm-Da; Tue, 17 May 2022 02:05:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C8827404FE;
	Tue, 17 May 2022 02:05:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AFE9C0039;
	Tue, 17 May 2022 02:05:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AC4AC002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 02:05:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58C4F4194E
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 02:05:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MVbN76jg9y9j for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 02:05:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F0C6E4027C
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 02:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652753153; x=1684289153;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=H26s11c+cWCKcz0F/X26CeSP8+ctLNYb+8KZJ7Yj2sw=;
 b=cDq9ed9OsJ2NRiBvWYto4VGd4LmM62BCaAfQVjumg7MfOOMx7tMRSi9V
 BWTRmNDo/FfsvZXh63kH/dEFAx5DZgFHIzWEr4a9uug6Bm24GmR2+F9SP
 eSgC9atwREPabRYwOZEINaKy7Yg2DIMdojIFV5MtkcUZbBJy+U/g7xanN
 r70j1RrjFkzG4ywe/5zOyG3/FOHiS+jNiNJ9JvAcoIQEi84KG8Ef7+8Lh
 T6NfN616agsYxn4AA0KmelMm6qwC/mzb4GdQ/lle91rL1/kyo99uyM3Bj
 pEDvfaZZSz+gqag2+pwbOcK3lZ1gaAbhR8qzJ8mEL26k/AtAWC6FoTrK8 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="270967331"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; d="scan'208";a="270967331"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2022 19:05:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; d="scan'208";a="596846285"
Received: from ctang1-mobl.ccr.corp.intel.com (HELO [10.249.192.251])
 ([10.249.192.251])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2022 19:05:45 -0700
Message-ID: <6cdc43a3-72ba-5360-0827-6915ef563d64@linux.intel.com>
Date: Tue, 17 May 2022 10:05:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 6/7] x86/boot/tboot: Move tboot_force_iommu() to Intel
 IOMMU
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
 <20220514014322.2927339-7-baolu.lu@linux.intel.com>
 <20220516180628.GL1343366@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220516180628.GL1343366@nvidia.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Ashok Raj <ashok.raj@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Kevin Tian <kevin.tian@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Ning Sun <ning.sun@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Borislav Petkov <bp@alien8.de>, Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jason,

On 2022/5/17 02:06, Jason Gunthorpe wrote:
>> +static __init int tboot_force_iommu(void)
>> +{
>> +	if (!tboot_enabled())
>> +		return 0;
>> +
>> +	if (no_iommu || dmar_disabled)
>> +		pr_warn("Forcing Intel-IOMMU to enabled\n");
> Unrelated, but when we are in the special secure IOMMU modes, do we
> force ATS off? Specifically does the IOMMU reject TLPs that are marked
> as translated?

Good question. From IOMMU point of view, I don't see a point to force
ATS off, but trust boot involves lots of other things that I am not
familiar with. Anybody else could help to answer?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
