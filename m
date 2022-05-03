Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D98AC433F5
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 07:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F1F9414C1;
	Tue,  3 May 2022 07:50:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C5e84BLLX_RF; Tue,  3 May 2022 07:50:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A030C41497;
	Tue,  3 May 2022 07:50:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6622DC0039;
	Tue,  3 May 2022 07:50:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47498C002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 07:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 348454012E
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 07:50:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WYOcWQsA1Sdo for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 07:50:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CECF2400FE
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 07:50:20 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id a1so18968865edt.3
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 00:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wp+HuhCzVQcbpzvT/sQrzmDjeIdh00lZI9oDxB6WyTs=;
 b=MaRFzGoMD1a278grMU14/yYlEhePHu15Lav8QNQrQHkccVbXPqgmvM1VFUtuC9Fjf4
 uJ3Rgbif7K6L8Ar8zRmKbftuhHKSa1UQ3SwebB9FJsDSmAGIbAM/w9B4Pma+MsXx73Av
 tBlw/wqeYyPZWnubeZzUsmbpdMPm/M0Fs/b6h3BmrufAJfacj89ELyGunz7ZfLR4dbcQ
 8fzP9L7Ut+fKZrCPOpNjXsoKndESVxRp91TmVHnheF4t6Z5QCcAfvoUrYdJaBATgzHK4
 L7wiHAO+Kbyg/3nyOqSVZr5kgTn+lepmUGIj3npYWsgp9O3lwfGl0Qx957ysvk/ZK+xQ
 ksgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wp+HuhCzVQcbpzvT/sQrzmDjeIdh00lZI9oDxB6WyTs=;
 b=zOWnkR46XpvmffTqDJe5L4q/rZe8CPmsoQ81DHJ71Wv51tfrzxfU/bf/9TGGrCfb6/
 G2zEWWuJW1kTwGhxyqPk0dzH63EVFccctpqPh8qjIYJWeaVFPPj5FRCGl7MdoMsMr14c
 ova15jADynwhWOkKQyPiFJRlGQbs1yLpzNjUxUD0kB569vGWEJElfWIA2yArwsnyLB7k
 BfHEf+XGtoxS3NUYmjqQqqpfEoUQfN1RZSRLr5zCQEyxoUCeHO4HWKN4W7+X7heeWk+9
 mOMxwKybuN8UsTO8P2Jd7Zqoh5Ccb4NpzaHjjffPs7huO679EHtdnxl7LfEJUhEVN4Nz
 cBQg==
X-Gm-Message-State: AOAM530T+jSl3q6w+P8qSDn7kgkdZAyA3DP6xtmDXGTZZLpdl4v2mwwB
 SHdaxbSrt8fOhZAWcUCAtj+SJQ==
X-Google-Smtp-Source: ABdhPJyVyq4b/kVlB63u3UarpBNZnJKtF6IDLyaW7pS64uWqHVVg2cH/YhsdXpfIKhYgli0kY9qkQw==
X-Received: by 2002:a50:f1c5:0:b0:425:dd04:b7a9 with SMTP id
 y5-20020a50f1c5000000b00425dd04b7a9mr16790672edl.388.1651564218903; 
 Tue, 03 May 2022 00:50:18 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 cw27-20020a056402229b00b0042617ba6387sm7464883edb.17.2022.05.03.00.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 May 2022 00:50:18 -0700 (PDT)
Date: Tue, 3 May 2022 08:49:52 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YnDeoGjv/dZnu+YQ@myrica>
References: <YmbO/l5IwfBCHrl8@myrica>
 <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
 <YmgiQZZyFxsJ+9um@myrica>
 <63582490-a794-fd11-0380-44b27cc660b7@intel.com>
 <YmpSv48aPIbVXqGi@myrica>
 <044595e6-e5d0-26c2-af8e-fc9d06906179@linux.intel.com>
 <YmvtVRlwVJjStXc0@fyu1.sc.intel.com> <Ymv3fC4xXqe+oMRK@myrica>
 <Ymxke+ihgwNy3BCE@fyu1.sc.intel.com>
 <3ea91623-97ea-f318-70db-55f08922d7ce@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3ea91623-97ea-f318-70db-55f08922d7ce@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, will@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 zhangfei.gao@linaro.org, Thomas Gleixner <tglx@linutronix.de>,
 robin.murphy@arm.com
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

On Sat, Apr 30, 2022 at 03:33:17PM +0800, Baolu Lu wrote:
> Jean, another quick question about the iommu_sva_bind_device()
> 
> /**
>  * iommu_sva_bind_device() - Bind a process address space to a device
>  * @dev: the device
>  * @mm: the mm to bind, caller must hold a reference to it
>  * @drvdata: opaque data pointer to pass to bind callback
> 
> This interface requires the caller to take a reference to mm. Which
> reference should it take, mm->mm_count or mm->mm_users? It's better to
> make it explicit in this comment.

Agreed, it's mm_users as required by mmu_notifier_register()

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
