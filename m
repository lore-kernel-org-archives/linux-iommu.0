Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398570;
	b=Pj78QksF8Od09zvNHo0AzKQpuVSR1oeq8Y1p4+bXirjHCXeKoUPTHzyEWDcNx8bY18VN
	 3VF2pIW7K8Yqsro2ojZESnLn5Wvg3vldO+LG/b0C2HssytWrFUkCp5j1SbaGZJatEShdU
	 DMpbPOoAJqTaXovEDSYgan5GquEKytMJOyChk3mqvYbW6aIzFXtcL0lms2QMtA+1iQBKU
	 XqdfKzqXz+D4Gjm6Ulo5fuiCXbNszWqbuOVdr9LXN1uD3aotY1VTc9a8B6buNaIxDGgB5
	 IcDMlcjQvXKNb2gR1zWt8yJuNUjLDi+iGIOW81U3n/f8nC0/IbwnWHqqb4znmnmigPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Mf3ojcAaOl5Wd2bB/OvSpA9q4iDAVUFZx+UCDfwTy74=;
	b=VV9jVx/uabsn6Wc0TTAp0lC1cxo743fLV4UpkWGzKDq6uoYYdCDDgwPbI9NhW8bDH31W
	 pf5Udwh49dIsNDzl5RXzAuKeIhmtj5PdrYHN+IM30vT7Jm1jnlRWpYeipiot9YLCZVSvq
	 OAfbMlakCK5TkBCm/np2tAuYyBa7tvdZHfV/suS9Aqrr/ODOr9wn/3qTo6busZO4HMZ2I
	 97e7R1LkP7D/YVvsAND28isWZOYP/JtboJNa7lK2PI3cUqgWA1D3mwxR1wdoL3HFNBA/q
	 lhvZLAFvYTtAxLaauvYrd68qMtSFbvUpTnNrqa1L5pH6/9uvW04GcRrniL4VoA2KeOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sQJ9qyCW;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC48A606A32A
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 12:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC48A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sQJ9qyCW
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-491aaed7565so1862431f8f.2
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 04:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794398568; x=1795003368; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mf3ojcAaOl5Wd2bB/OvSpA9q4iDAVUFZx+UCDfwTy74=;
        b=sQJ9qyCWCjiDPKGsUjshl6uKUDnBFfmrw1fZ0bAebnifEUU3RGh7N90jS0xvmqtT98
         6+BvaV06eigvIds8ZC8isnDR+LU+3HvbN8qAA7BfO+pTRmcgNfPlEFs6XH/V+dMFSlsF
         VVZj+G5cKg8dN96e5WhvlRX+HWRVMPR13mM7z2Oney5BCA0ohnQyiC9oEW9XsDHNtyIQ
         bmdW0/m9MlAJPmDEMox1Eir4fOCX/pXhvE4qrMIbAWzcT7TeLCR7R/+qtDtN6VfKJjRp
         ZgUYOt7/syRMN7w1f77BDXh6vco4zb6vMWpPmcDVfY7Rewav4J2rKepksLfzKwySbvRV
         +Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794398568; x=1795003368;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mf3ojcAaOl5Wd2bB/OvSpA9q4iDAVUFZx+UCDfwTy74=;
        b=HNgMWLy8u6bhCdhj69Ye2+boHuKWeNfjxe6Zb6Lpj7BW1Tdg60RANPSx75fIPQgJOf
         mJTALTcI6aOrJj4xU34Ub+4X0rWNfl9mnJX0kwTg/2RHJqGvlVND87wc/z6UUD9XL4pE
         Ez53DYDhhS1isybpfEbC1/1rptEd+ZqAMnfDJyhL09zV4ew6L1Am/ZOCoN+uv1gqOEE4
         7eNKWD/SVQyRatqieIyYOBxNkzsfg3+pTJpZNsVAv+rpoz2iyzHYVuEihdSEjkVjtOQ1
         Mpc3BlHsb4p8yAiVibipGU0oqalK/IEVeL32sJjm3WizjXFknvKvRUaJ9Q3R2qhwwuZK
         ZSBg==
X-Gm-Message-State: APuU4Z9qMsy7IixhDjWF02Z1CM+Z9BRSi3odcuX4WDEFV8X5OU+5tf7k
	NgWoeZZRMA3bmpUnXE72gmaZoAYF3fAsNgB1vFdUniKfef1ZvH6ysazTyldwIFO7kkw=
X-Gm-Gg: AYBFou2j9fBDLQYmTEkVcdYyJOGKPxH55ps5IMjDMHKlp8ntFkjh8BHdArSTACI+Hom
	gBVRL6UeFUVScsAmWWL9sWmdjpww0pPUHwWU+g7fQLlrYWkoBgBzIJ5UcY4NzAlxBfIBs11l16c
	rx1oZQDuKbY+FAoPFh2vowQeL32IJE91XqvHTCx5m9rkBK9T5YtoY9SA1baMuC7rHbGQ5mSTR5C
	ZI5Q2NgezWzFuVM+NgcREVRBtFWok7YohORswHEQ4jm5bwuUKy0ioMCn5zT4TwDhNzu54gU4SJX
	QpCIPmu571Tjxskw46iiAFIB8A8Y12fv3/Y84h1uR7GS31CnjePawDyMid97AYdJIA6YWT2nzSv
	+zeysQTTvF8diu29bGpgTID2jr6GOFCOidqk2v4KksyH2DJ53enKblt7+VOxv6k2t7j0r/45+r0
	nRt8sfrUpSxvOxEAzZnHTiOUQPFHvP7tJGtavgAeqORoigBzZQgO3vWbaa39/foQCXfljkr+F2r
	KxRcltrlLECVkmu8yZsRPYZ2ibMRwD+Zi1xy7WfBlErwC4vrBE4rlyW7MkNzR7GQjDrdVkW4h6F
	XkslWMMxunz+nyI0+svuwmzi/BE8ZYZu+yRBHqcW
X-Received: by 2002:a05:6000:420d:b0:48b:1a0:5630 with SMTP id ffacd0b85a97d-499c86a10f6mr3780756f8f.41.1794398567805;
        Wed, 11 Nov 2026 04:02:47 -0800 (PST)
Received: from [192.168.0.167] ([109.76.11.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835c377fdsm8869991f8f.21.2026.11.11.04.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 04:02:47 -0800 (PST)
Message-ID: <3713bf13-cec6-4b02-a29b-8f76070f03b3@linaro.org>
Date: Wed, 11 Nov 2026 12:02:45 +0000
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
Subject: Re: [PATCH v7 4/5] iommu/of: Require reg for iommu-addresses
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
 Eric Auger <eric.auger@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Srinath Mannam <srinath.mannam@broadcom.com>,
 Oza Pawandeep <quic_poza@quicinc.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, devicetree@vger.kernel.org,
 kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2026 17:14, Vikash Garodia wrote:
> @@ -257,6 +252,9 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   				}
>   				type = iommu_resv_region_get_type(dev, &phys, iova, length);
>   
> +				if (type != IOMMU_RESV_DIRECT)
> +					continue;
> +

This change is not about requiring a reg though, which is why it should 
be a standalone patch with its own justifications.

Basically the patch should state why a mismatch is dropped instead of 
being reserved.

---
bod
