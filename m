Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526FD33344A
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787034364; cv=none; b=IMvek9kEhs1yVRQcVq3wJRQ5EGf3C6oXV98bGMUPhqvMbmIrCIXanuc0IFO/NGPDV1KIHefaJfF3gK222sj9h2mSyToy8+vKJkVDWmI15upLr3gZq8ZVJgRbbr0SCwrW3zVglkq8nNbiQY8jnSSGqzqjjxxlFwn1EHCUApvQVEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787034364; c=relaxed/simple;
	bh=2mrRYBUZB6QXqcc/lWECjrJo8ItcqmQvUwDzXzT2cek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9xNR+ilMjx6MUOxBU5kcA78EUr6tsh6hMShSvASoUeAr2eOVQPWR3mpo0mKT8V48WTNPqIuNDObWtpJSBU55yrW94sS5JNS/+3Y5bYWLIYLwQ9dyyN3J/r+QRycXK+rb7cqkPXjAwa0cGVPSr/KI3M5wI04p6MsdBfb4fCSNXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f2sYxbLV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZyQR6toH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f2sYxbLV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZyQR6toH"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I6H3iw297682
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 06:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QpMSnfPhODIl1ejhgbQgYJBMEXQkyaJTdofbzdBjnW8=; b=f2sYxbLVVxHHE8ah
	BLL2hEOs11e8uGfhMGoJwcmplrDhvwX33dAV0qiWRM2gDpjxJVPos/JU02gMW9FC
	LXwzVEPGU7rJi5TIK5da9CVzvzkcJVuj6EHpmZzzxojPfowe4uWJw1vE56Kh38vH
	PpjZDe3+yq0qUA2tUIqzPDgLNB+qvDT0CvDtc8kuiXB875zbfvrZ0HBTaer95ILn
	iFiq1bXLOsrZHIspu9HOdT/hDYdagYLCnHuJc6s7BLHeQiteNQ8b7Dv4wzHpIzVF
	NbRytfgkQu+PFQ5J28BanMviMap2OBU3khIdZ3UoRxyndp/8zj7rcQHuopvzHk/C
	giU5Xw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4dcn16y1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 06:26:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dd87656d3so5399931a91.2
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 23:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787034361; x=1787639161; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QpMSnfPhODIl1ejhgbQgYJBMEXQkyaJTdofbzdBjnW8=;
        b=ZyQR6toHkf9IkUEx+WJlF9ssZATnoHMdoZ8CQI94qto939Dam4pEt3Zz3Y6pwBgeIp
         rZiOr+4eq+hi5Kwjy8rrjSLBiWdtCwz8EYFPYiYlwonAntu04Vwh7fjZW/ivgWwnu1Cm
         90M+u3IXifreXNhKYy6h3ZGabGi+vsjbk++Vl6EMduiX+K1pZWZ9+cqwuME2MiMZ4/nm
         EyyFZTmACWk9R6JiD1oQ75BJ7+3WXhM9HAkn3+kx1sHykdQSzZzLraC84cyPnRww6sY3
         Te7yq+PlerYj7CRNMK39Tcik+ji6j+wFbZG4s+qGhc3O1Xa7DP8meH9JJ96+krnsTSaC
         bYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787034361; x=1787639161;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QpMSnfPhODIl1ejhgbQgYJBMEXQkyaJTdofbzdBjnW8=;
        b=LP/WUZ8AI9iofGNqEuuq88tj5UY+sydeDy5ucQ/CFOO51WS8N0rPHgtundsm9/sa0q
         wCkQsgNL0cYqq0E44dJf0r7bub+YNlniBjG9QTHNz+xtjY1+itNwnAwlURAvRUXCb/cz
         0kM6E6Y0dWGp2J8X15AfWYVjflV/94mgq6zrF9xzSC/OhfLE4I2LTsdekJNF3zRL+ut8
         yrnFbxWm/Aivm3Vh+WKQcBK2QZK79ASJdtPkntIGXdSgXXskmVV6E1wT41B+ign1Z3Tt
         oycN3uDP2S/7T3oz67oh0iUNagpsUuuBGxFECwJC99wYW6FLnA7/qlht5D3Ue63Ip5Q+
         5Ejg==
X-Forwarded-Encrypted: i=1; AHgh+RpbjNDJxsVj5FRgdeOTAUkEhXNhXr28lI2GnA+7TPDGIfvm2QAObDlOojbq1uVJamWjzZpCzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEmBfJ8O8sja3EnylthXxdHeJtXnYWIXHtIKc2GjSAraNuWzDr
	L2TTT6pJwXY6QaSjzcGRUQCG2jUovwvQGyHpJWdpx0wlnjuABqnWHwPnwwcipTLRVOtPwjJI2N5
	fFuzDjaPgwge+paktQvGYQEODLEtk3iu/VP1BSwPh9UWwWqlY51v9r+a6Hw==
X-Gm-Gg: AR+sD10Rwsl+DRSzm5q0n1qfr0tuNomraHVQU5NXB19misQ5+VYzLFqN3TD/mGuRrBR
	m/n2SOySfDK9gdP6i7Na0O4zptu5oeXI6XwcUa2YxuSvw9kJ4ZJPhC6No3bhbcnqt4TsowQU1mV
	6XNy1U+OyOqIPQ47o/2aDh4wZ36/ZxgCs2YnDhoBPrjlk2T6eOOg+m8bn7Vc7p+ftoW8ylaVKDB
	PMbBkI0DADm+0TF29z9vGYlpAa33Msa3cfYwQ9/zwQ9ntyY1ss/Wq4Xze7RqKca7Y8dwW+lrdxo
	BujkQBtF35W7662Ttuuy9hD8RByD625UuVEgR8SAW1tYnAIFTUu2WGuMq5OQGFLRn12vNpGRyPj
	p3rOydBOOR48Snk6nm70sPl1f85emcQ==
X-Received: by 2002:a17:90b:48c1:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-3933b792c20mr35951586a91.9.1787034361304;
        Mon, 17 Aug 2026 23:26:01 -0700 (PDT)
X-Received: by 2002:a17:90b:48c1:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-3933b792c20mr35951459a91.9.1787034360780;
        Mon, 17 Aug 2026 23:26:00 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531ff679fsm7486482a91.14.2026.08.17.23.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 23:26:00 -0700 (PDT)
Message-ID: <c1da4243-36d1-4b65-a5da-f660ab8c63b3@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 11:55:50 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] accel/qda: Add PRIME DMA-BUF import support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling
 <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-11-69a02e9090d4@oss.qualcomm.com>
 <l7gt2mr3rrnzmkc46ntqw5e5sirdimavv5do4wmdf6jktryp7g@772ovv3qlgcv>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <l7gt2mr3rrnzmkc46ntqw5e5sirdimavv5do4wmdf6jktryp7g@772ovv3qlgcv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BPW4u3HGya5iyjC83fiSlS1eSjIbxL_b
X-Authority-Analysis: v=2.4 cv=Gs5yPE1C c=1 sm=1 tr=0 ts=6a83fafa cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=BHqhARD1X7WWxJJUoOYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: BPW4u3HGya5iyjC83fiSlS1eSjIbxL_b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0NiBTYWx0ZWRfXyMH+JSaMhaoe
 D/fg0t0ulBNxPXEyNd4RD38Q3ncCAAhmg5NZ1EqfViG+F2FNqHrvshNM6kpBZu1eYVcz8ZJQpz8
 NZRwckERcKahpa/yC35h/x02Z8eX+fG67hjjkk0aU5xGbH6ZP+o438FEg/MV+aY/O/j3zUncWfF
 LQuRfxa/dKCLtkdOgoPj4Ze4tKOWIyNc7jrNVRv9HT32NxhXqbdYCW6GFMgwe/63lX7e7DH/eQ5
 k52sQDE6n/4WsVj+DKZG3p4Rpv+1QdHOQ4D2v8SmiXnjwaoRz1MlKzLGdzFTgrRzC/hk0s0nPCA
 1oxIHixtdaPttFqGZHPiWb3bS8eTyjUoImgQopj4SpZBE1ySoGvo7+6gR+LIyU/S9geTwndxKYu
 uwrn3zPem/dXHjFNbWIr/tsV220zhlPX9ZOLhq3aEVw63NOSPTri97+9YHBYW7QWnUFIX4WsuQ3
 EqIqkttD3rgAJZfrdDA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0NiBTYWx0ZWRfX2uwNVLwQO3uT
 vBPRGt/ZqQKvYpi9tP4u7a6k1u2A/g9wG5/tmKV7xtKp8h+GOQ2rZv4sBzVW13bRrTxtOplxTzs
 IyP9rEypnFLt9cVx16jB1t7w3ns9UQw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180046

On 18-08-2026 09:25, Dmitry Baryshkov wrote:
> On Mon, Aug 17, 2026 at 10:17:46AM +0530, Ekansh Gupta wrote:
>> Allow user-space to import DMA-BUF file descriptors from other
>> subsystems (GPU, camera, video) into the QDA driver via the standard
>> DRM PRIME interface.
>>
>> qda_prime.c
>>   Implements qda_gem_prime_import(), which is set as the driver's
>>   .gem_prime_import callback. On import it:
>>   1. Short-circuits self-import: if the dma_buf was exported by this
>>      device and is not itself an import, the existing GEM object is
>>      returned with an incremented reference count.
>>   2. Attaches to the dma_buf and maps it with DMA_BIDIRECTIONAL via
>>      dma_buf_map_attachment_unlocked(), obtaining an sg_table whose
>>      DMA addresses are IOMMU virtual addresses in the CB device's
>>      address space.
>>   3. Calls qda_memory_manager_alloc() to record the mapping and encode
>>      the SID in the upper bits of the DMA address, matching the
>>      convention used for natively allocated buffers.
>>
>>   qda_prime_fd_to_handle() wraps drm_gem_prime_fd_to_handle() under
>>   qdev->import_lock, storing the calling file_priv in
> 
> Why do you need a separate lock?
Will add details in commit message,
The lock serialises the `fd_to_handle → gem_prime_import` call so that
`current_import_file_priv` is valid for the duration of the import.
Without it, two concurrent imports could race and each see the other's
`file_priv`.
> 
>>   qdev->current_import_file_priv so that qda_gem_prime_import() can
>>   retrieve it (the .gem_prime_import callback does not receive
>>   file_priv directly, but the context bank to attach to is per-process).
>>
>> qda_gem.c
>>   qda_gem_free_object() is extended to handle the imported-buffer
>>   teardown path: unmap the sg_table, detach from the dma_buf, and
>>   release the dma_buf reference.
>>   qda_gem_mmap_obj() rejects mmap requests on imported objects, which
>>   must be mapped through the exporter instead.
>>
>> qda_memory_manager.c
>>   The DSP is given a single base address per buffer, so only buffers
>>   that are mapped as one contiguous range can be described to it.
> 
> Is there no IOMMU in front of the DSP? Can we remap the buffer to a
> linear are inside the DSP map?
The DSP firmware's buffer descriptor format carries a single
{base_address, size} pair per buffer and it does not support
scatter-gather or multi-entry page tables on its side. This is a
firmware interface constraint that we cannot change from the kernel. So
imported buffers must present as one contiguous IOVA range, and
non-contiguous ones are rejected.

Will add this information in commit message and during the check.>
>>   qda_memory_manager_map_imported() therefore walks the imported
>>   buffer's scatterlist and rejects any buffer whose entries are not
>>   contiguous; contiguous imports (for example from the CMA DMA-buf
>>   heap) are accepted. Whether an exporter or IOMMU coalesces a buffer
>>   into a single range is not guaranteed, so this is verified rather
>>   than assumed.
>>   qda_memory_manager_free() skips the DMA free path for imported
>>   buffers since the memory is owned by the exporter.
>>
>> Assisted-by: Claude:claude-sonnet-5
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Do not assume the exporter or IOMMU maps an imported buffer as a
>>   single contiguous range; walk the scatterlist and cleanly reject
>>   non-contiguous imports instead (Christian König)
>> - Document that only contiguous imports (e.g. CMA DMA-buf heap) are
>>   supported
>> - Return -EBUSY rather than -ENODEV when no context bank is available
>> ---
>>  drivers/accel/qda/Makefile             |   1 +
>>  }
>>  
>> +static int qda_memory_manager_map_imported(struct qda_gem_obj *gem_obj,
>> +					   struct qda_iommu_device *iommu_dev)
>> +{
>> +	dma_addr_t dma_addr, expected_addr = 0;
>> +	struct scatterlist *sg, *s;
>> +	int i;
>> +
>> +	sg = gem_obj->sgt->sgl;
>> +
>> +	/*
>> +	 * Verify that the imported DMA-BUF is contiguous. While some platforms
> 
> Which "some platforms"?
I'll rewrite the comment to be precise.>
>> +	 * or IOMMUs might map buffers as a single range, we must not silently
>> +	 * assume this is always the case. We loop through the scatterlist
>> +	 * entries and reject any that are non-contiguous.
>> +	 */
> 

