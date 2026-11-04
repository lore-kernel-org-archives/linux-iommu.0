Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809394;
	b=bOKLyCkYdxAGDfs0xnjoO/2oDi47/eh8Wjpcly4gVqYMEFxKZSEpe6JifVB5UAhlNqsf
	 BtbE2aCeIb9PI1dY7g2OowIW0sXroQZlyvc8yAEErl7KlhTrOKQWocKcmR3eNU5WC2LbR
	 VBQWkJWYlnsXkyJoZwWo8RnodXeDUmcHKJI8K9MzRicBTOMBmYR552HKDi4Hv+HjxhF8V
	 tAHX9Ctn6BZXxlsOIUyPlFLaTURj6yDImxkqPhyYSRZqZ4oTfpm7gDYJ+7CMqBGhpiB9U
	 cWcxbKnkeycsmDfPLBkHXIuDGsu5wSfLG/iOJwjd7Uev4TjZZJQqglSikCvA+qPxTTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vocGYEw/5tonadEsgL+tN2/v9RawaaHXU9Cku3rNbjM=;
	b=g1hZese30vBoxaN2g22tDhGfvVq7ENhHTKWKt2Z1wOOFSSgCa9B+/ST/cOG+35rcoXfy
	 O6G6pElnLyr9iI+Ml6VE1HHt+/aX4nIadjaFneEz22CoEumTNPPLY2ndvmDQqjOdI2raW
	 W4zrxhHuYwgdWYaDZk7U6I7GAMa90xFA6ZUEKUI6Bfks+medmZO0bnNVwha6NKUPQtiB9
	 sCYJz4lBE2psWniZthotAFFVy6ls5vGBQxo0Qyaz+TL9HGAO4vVqwurzXTrMzgc55y2xW
	 ZYNGty+VpF/pXk+4Tz7BtfnK8YogjjoqZ3KMppCyW7TA6qLgpceBbt2awaauZZxa5qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kdQJmj61;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40346606D80D
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 16:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40346606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kdQJmj61
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so12182535e9.1
        for <iommu@lists.linux.dev>; Wed, 04 Nov 2026 08:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793809391; x=1794414191; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vocGYEw/5tonadEsgL+tN2/v9RawaaHXU9Cku3rNbjM=;
        b=kdQJmj61fGHKGwx1dWASklCXYb2Tb47QaXXzlzfqZ6Y0VoSkXYa4rWD0fwo545mfCv
         DvAXBH7Pr+2kHxi5i0a+lX0Ym+ajj6aGirn5v8hnL/NcR8DdYbM9qChmRwQ+Cc3Gomru
         MqbakvtOjJlTpbus7yTNCjMmY5MyZ1l4gQo/v+9jdomiFEAuxBv5Qhrx2vyWeJ6keN+F
         DKW4xbo7Az7l8Jw+xnVemDd/krlGcGBSjEed9Q5fVMG2ES21/X4MNY2VhNTqIe/7Wv7F
         BCNEDDmd/JZHXYHrIDRf8zmOWZaxp29vOKlZMILZI0zt/aeY26WLRdclQvPZMMHyUdNT
         pQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793809391; x=1794414191;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vocGYEw/5tonadEsgL+tN2/v9RawaaHXU9Cku3rNbjM=;
        b=DPEEXPLqjnYKHLJrc5+9DzAJ9Kgn7QWP1RHdclDuAnWTDiwXI6xkF3ITDkghYOubHP
         VJT//yPgchqXNeOP/orMM9+WRpEQ1eE6DvYQPGr7mgnmBtm4tNi+RU36k6KPHWcpT4pv
         RTKXDm2r3V50R5vvCwlgEBdKsLYa24/3ff4k9G7U7aME4omx/5xBtMPhZk5RjjbrYm15
         e+z1PdDo+HRSGU5vT88A1eY27L8O7LT1T76L0H6OjmNdIytB/CNV3sXpezGRdFWKHydG
         ++xpXjorPY0H89mh77XYhR0y5E/uYWe15clEBXzYEwwzMQuBIHOtG5Dpx6vQerGzACNk
         rFbw==
X-Gm-Message-State: APuU4Z8pMNJWZLmvD8GoZ+UqHIG0jEg3pO9bL8r0AvWFpLi/N3MCA3PO
	SFWuuhy1+rk6ZjDPriN55/SCgmoivW2+MKtskUIsetygzajRP95VDO87l0n5ZlXdB6s=
X-Gm-Gg: AYBFou2ISWz3WbWtMH7BAGmEMt7rISTbX9eC4WKsWDobN2Mkh2DnJtf+SWc6EdbyrYP
	nrpgs3PLbj/pJVBnVn9Y4Qr+Jh+RUDlyCODoEbGSRIG87XZGaAxRpIiWBqeOm0B/7mN+Kxn09dK
	UGj96w9nLb1oHSF31W8N10feOnTm0g62Dn72P3mOi+mPoLDdT+cAGeSv85tRqDlEckNQGyLMT9+
	ZwkuNAUvxsyHMOQJPSNhhpyemmdO80+hqyUEokgdwYS5UXo9l//yjfJEjnSroZKYNjAbH4I9vmt
	CjOk1GHocrzIC6W36OymUA8AETmiVZ5dfqZNXiMnLRdrQv+d8eXGbRA/AUyj0/6FHmdrcVxrR70
	oSeg/jevVSBFa6cE3ghnbi1lTlzN+V7ww0LKAvukM9B5p+0/s5QeUveZxBnjlf+NQ7CK8Zzi0sy
	bftawKewOHVkNZrU3gxhzbYVqREh0z61oZ3bhcua/9OJNLyl0Pkfomxz4wnuuLlw+AZS8B1Fwq6
	/O6fCHKSppcPxt99s9IPlGzZum0eSGHXJwCicCTkiekFw/cnEH9bPGBIcGJd2CVMqnjqErffk19
	d4H/6l0IhjIHzXJJLyCVy3CGXjeDu66NHwIK9u+avg==
X-Received: by 2002:a05:600c:1907:b0:4b4:a551:681a with SMTP id 5b1f17b1804b1-4b55c8743d8mr75395e9.3.1793809391436;
        Wed, 04 Nov 2026 08:23:11 -0800 (PST)
Received: from [192.168.0.167] ([109.76.163.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a80e0fe6sm168477495e9.1.2026.11.04.08.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 08:23:10 -0800 (PST)
Message-ID: <f416b51a-0775-4834-9e1d-af8a72d9a1d8@linaro.org>
Date: Wed, 4 Nov 2026 16:23:09 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] of: Add support for "iommu-ranges" on a device
 node
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
 Eric Auger <eric.auger@redhat.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, devicetree@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com>
 <20261103-add_iommu_ranges-v6-2-361f3921a133@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261103-add_iommu_ranges-v6-2-361f3921a133@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/11/2026 15:29, Vikash Garodia wrote:
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 5c266511db78910d6fd221af5437cecff4931c22..0428ceb50dec58f11872b4fb64e283fa8d9046a3 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -185,11 +185,118 @@ iommu_resv_region_get_type(struct device *dev,
>   	if (start == phys->start && end == phys->end)
>   		return IOMMU_RESV_DIRECT;
>   
> -	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", phys,
> -		 &start, &end);
> +	dev_err(dev, "non-direct mapping [%pr] -> [%pap-%pap] is not supported\n", phys,
> +		&start, &end);
>   	return IOMMU_RESV_RESERVED;
>   }
>   

Same feedback as @ the last version of this.

I still think this behaviour change should have its own patch that 
preceds this patch so that the logical change is clearly explained and 
understood as a standalone change.

Supporting iommu-ranges != not mapping misaligned ranges.

Otherwise this change goes under the radar of the new functionality 
addition.

---
bod
