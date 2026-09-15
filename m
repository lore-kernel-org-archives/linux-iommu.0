Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6464078D1
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789514478; cv=none; b=oEPJkc6oIy/+Y0+K3d84IB4I3SJe3UNKfGSaagAu4765Ky4Sruu9StXiqRxaoG4gqWfGvOy/gucAs0vc6D4ZVwg8y9rZQQ3KM/ot2Fe1FBCBqVh1DBv1BuCVX19djY+3g5db4QDZgpMIl88BawQ0iUEv5g3Rb4tOgj3h2++qYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789514478; c=relaxed/simple;
	bh=xmpAHbc0WkXgKRZPrvgHxoTAgIyKCkZGiPIgQRMRYVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMLPhs8eQ1/uHXwKHiYwJEhfFltdVkk14PUUXeLbZL/1UQsWctJPD6jcfe1zfeWu8dtIyhUeOiq3KZY56HsFtEHqkUkoNje5iQIT8s6AQQ2Ef1X+VXDJGUVxPtoVwBKRE+GtXJxwRjrDJfeeu4NkVZTDKJVU9if+88mtS2L58GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jVpHuJyz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZhuQ35w+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVpHuJyz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZhuQ35w+"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLYoL7840776
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 23:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lyKoyOjIfv9w+YYrFTayF9TTz7lNx0qSbUIbPxqiGT4=; b=jVpHuJyz5nF9Pyx9
	Tj708RnGg7QJ+1opQNvo1W8ygwGxR6NC70o3BUHhcVherBpE514SfP+NY5+NPq16
	j2TH2PItWV2fIywzy3mtzfHg0lgKAaUrviCR+aXtDtivg3iBqMua5QrklRE+spVg
	2znFZG+ETjCzNKIu4wtcwYHzGNlkT9Z6FvloXPl37G8gW3rufmyQD6ps4SgC2FCx
	2n2U9z98pkQIsC2Mek1rhQ1m8e4153RORiqLYddRQY+OigO6AqFwi4xjmyChuRCL
	J04NkXLsAVm1dTJy1Lf83wzFU2uSUttWpWfyAaVdOGbIWMnTtlPh1IDJ00MFXoDn
	ESxApQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqdyw8bgv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 23:21:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39e087a18deso1999900a91.0
        for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 16:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789514471; x=1790119271; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lyKoyOjIfv9w+YYrFTayF9TTz7lNx0qSbUIbPxqiGT4=;
        b=ZhuQ35w+i8nKcjdrIcEVZa3DtsA2SYpBRmHVF6tTqOKyVgPUNp8aKySt5B6iOk5Nks
         Az1JAnzja4XhtR326adPPRuUZiThr5wMLppCFWzW6f78DySGw22RvaWsErHELrzJX/bP
         y1i1vY+fMMx/1PiGyF1x9SPxPyr8uYxOfCuDl/Eu4xBT1GhS0vOoaCONgZ75p9NK7b3N
         Cvr1h+hnlXiMPExAp/1zf219v9Op+SOWoNtHVoACytiTUiltcSL9Sjhjv2qSwTTrqrYY
         /XEZsyGzbJ69yOBA+iXSlVFpyJNuF97DCY7Kd3IAcDwvdi5cfVKvTTfYfkYLhnDW7oks
         UTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789514471; x=1790119271;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lyKoyOjIfv9w+YYrFTayF9TTz7lNx0qSbUIbPxqiGT4=;
        b=Fo/CXlP26AcZhmYQ/tkZDVniczYrh5MxXZqxCNLYmU14kH/W+qecCsV08gCFbx6BOB
         Mrj9BVxiaj1TSr7J3qn9GpRzWf6FeTtbti9Rgdh/pQqTtRi7JKjj8SNevzsrzcXfmafE
         qKwgUU1nMcYqRj8i1mAnw8uCmDYICG4c/2SnW8jmOhqsJfUicU/cLywm8cKmXA26vS65
         IvJP9UvSaoaju4A092Yr3gTWjnZ4kyaRbMnxzCHm/CgFzNpGAJF1jDGSbMyRAektQnur
         9l5yg+6hAtt+8AyQc1VV5Pr3+YHUX5bLXTWotpfq+fCPTPxmHB1gp1/dNX7sVMotGd4P
         /Ehg==
X-Forwarded-Encrypted: i=1; AKwUvByursxSzwchwwW/3vvrW1Mg/eE/lO6NkKMYXIlpjzk+as1TEjMG0Ogi0PRb4KrXY71Gye8lsg==@lists.linux.dev
X-Gm-Message-State: AFuF++lYXAvrID17IfhkHMC1eKRq0UmBjB8q0zPbVBBd72xuukqh+jlL
	oHUuV7grkj9QbFHTHwVicxvGpgy0jLRjG4kuEYyfIrNj9gHIM+o2BnzRaa80eRxNiznhHGZ4iBD
	mkVI8Gsje5MEdHnvE6QvyYcJF8mFQjAWcgcKNjBUo+dHtzcM9nok4FvOpCA==
X-Gm-Gg: AYBFou2W9FwfEEhUDGDC9KufowEElJymuyMHxFAuTsApnywiX7ZU7B758fQ1lsB4IMe
	WuDJ2g5wweqApv/fuNbvJVH1G8fX8R6VxVbEGE7kxvSvRY97ncfRTU50+OWceQZVRZi5xpavZAK
	BDoqwXJTEczZTw8AYbXthn8qLb+7XVN6B4w66uaUlE7sCY7yWPuTaa4/c7g+aRHk/2mmXUjcm/1
	trV/0W02wK3R4lRDV1CfsNk09Y4iW9k7UGbigS2DhZs98WwpJ1o0aarLUtfJC/sgL0UZ7pjOqSH
	iuYdyPXK5iPQEHjd2JdUKrudbiebVAON21tAheoH6P7ux7Cqg6UqiRoi4IxO5CFdPlo9Cf/bvOU
	Evcw4zQT3TOn0eDAIzQ+L1lsIg9A=
X-Received: by 2002:a17:90b:560d:b0:39b:3109:10ce with SMTP id 98e67ed59e1d1-39e1e45cbaemr914883a91.16.1789514470781;
        Tue, 15 Sep 2026 16:21:10 -0700 (PDT)
X-Received: by 2002:a17:90b:560d:b0:39b:3109:10ce with SMTP id 98e67ed59e1d1-39e1e45cbaemr914831a91.16.1789514470342;
        Tue, 15 Sep 2026 16:21:10 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d11cb3sm1432321c88.6.2026.09.15.16.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:21:10 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:21:06 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
        <kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
        <baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>,
        "Eric
 Auger" <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
        <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v5 08/15] iommu/arm-smmu-v3: Disable the queue IRQs
 before disabling the SMMU
Message-ID: <20260915162106.0000145b@oss.qualcomm.com>
In-Reply-To: <0ca69e93a9370e4e172e4335104859648b8755c2.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
	<0ca69e93a9370e4e172e4335104859648b8755c2.1789446520.git.nicolinc@nvidia.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XSKIOpf-GaI2IMxvN-nnwUJaZuju71uh
X-Authority-Analysis: v=2.4 cv=aJ1lOr9m c=1 sm=1 tr=0 ts=6aa9d2ec cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=qr_CdHuHKQtOmQRTACQA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDM0MSBTYWx0ZWRfX579BZV/vhfZ/
 PKrtJbexpZkymC43utJYXqkg9B4/w9QLOAFTLcyWThwZ1EZX0AEJhyeRMzgqjUPARb3cI5HvMCi
 KWakffpeYa3C9BrBBkCHmVRBjYNal9FVSemv7Te/rWynnbyiOpQEthibWrvt6dcvelkMCMoFi4X
 L2OPO+Ok+Gi405sQoL8xziosjGqm7R+QN5rbSWzlnXRUvTqf8npfdKKpo/OCn8LkutNDwibqNeV
 RvtN3R/SSuhikrlKj7VFl9KVOWCeAVn0qSdOxop0ENRH6Yqx0JTRXo5AmfjH+qFM0mHsHZKKz2B
 CD6HYiUDA9kVrfisxZHEy+wu9Gnx4rddWkVi9qAsUj3tYobTR19seMx/+awZ+bki1+mTz5/Vbpp
 YtCkmb9ofX7Odbz79GpG2uDZnAZQaHA7+ECFPld4VU1ZUZJBLH/qpkZRgp3TUXDTgS0EOAJWjVi
 VHI+I7kr0N32z0WZgUw==
X-Proofpoint-ORIG-GUID: XSKIOpf-GaI2IMxvN-nnwUJaZuju71uh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDM0MSBTYWx0ZWRfX3SahX5liil/z
 F0ZaoV0AF5iCCppndMEeBlAURm+GBTN4uZob3rf1Et5uCMaCRPEXszambvL3EOY6OgUofqSHTYw
 f1vURS7h/H2ShKscdbEwkQ4xoDo1GZk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150341

On Tue, 15 Sep 2026 09:38:20 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> The EVTQ, PRIQ and combined IRQ handlers are threaded and issue commands of
> their own, e.g. a CMDQ_OP_PRI_RESP for a page request. Disabling the SMMU
> while one is in flight hands that command to a queue consuming nothing, so
> its poll waits out a full timeout.
> 
> Two paths disable the SMMU while those IRQs are still requested: a failing
> arm_smmu_device_reset() returns to a probe that disables the device itself,
> and arm_smmu_disable_action() covers an unbind or any later probe failure.
> Both can run after arm_smmu_setup_irqs() requested the IRQs.
> 
> Disable those IRQs first in both paths, so that no handler is left running
> once the SMMU goes down. arm_smmu_device_shutdown() needs no change of its
> own here, since it already just calls arm_smmu_disable_action().
> 
> Also clear an IRQ number when its request fails or is skipped for a missing
> ARM_SMMU_FEAT_PRI, keeping disable_irq() to the IRQs that this driver truly
> owns.
> 
> Note that the IOPF queue needs no such care of its own, as devres frees the
> IRQs before running the release action of that queue, which came earlier in
> arm_smmu_init_queues().
> 
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
I'm still not loving the disable_irq() in here just because to me it
feels like it may end up masking stuff we ought to handle more carefully but
I don't mind that much

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


