Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065A23CC310
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787032457; cv=none; b=X/oAkR16Wcd/H4V8w920Vbumd8WDDc+fGx6ZACacLLyohsjSN3klTuOQ6FKFdzDTWbDs4yuamdC7lJjo4HUrYV+MT+M0XbVVBeWHqKmWfHKtCtpr/2aWwVGfDwhJO27OUK3t6NsPbCS6FcsPzwp/1PgnWda2FfTAjJlaUe9OjGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787032457; c=relaxed/simple;
	bh=GosCLyy1/VLuOxPlTGn0Ls10HQdPNBqTDEuKCEOC9lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UoN1TcpGIgMDj3TA8MpMVIZ//mhAcMkFaY5bxohgIa/h43QrBKG0nce1mdfygCzqL7T1mtIBmW71INJLCzHh/Zel69/ki61qFsUX1jn9FOCEpkkCp+kfQbkZoY8xEaX+qsEuKYrx933N5nVDwZA6gbA0wKdPM9Tb+dRwli+CTf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nrbmFUAA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hzu0IvFh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nrbmFUAA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hzu0IvFh"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I28VQi2884797
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 05:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TbCaoRP4jgmLhzxgTcurQvCQNdUxxOfgWCAkLYtazKo=; b=nrbmFUAASt8pesrB
	u6WXz3wMqamtjyeAym9VEQ30v6hrhOpqNHLRXUYW1z69xos7AnS5/aaIr4VCSczG
	2hUyBz7eu41USoVjZRxHSV1xEdUrpHXsUMerp0kOsHW3MKOd8F7PuiLIRmdfdFMF
	tEzdmZDbZOx/GPAPsRbBnqRa+7Ju90vC2pfkQfnj76wXlM+/ZF4vXSCDIcFsbfVu
	ruQQdsAJ8IFCQ5EA450ikk6EUspdIKiobXhzSvQCBGFerd0bZfdwoHz4Hb6k+3mK
	2JmbjRf6C8qC9vAorkSv/A42ODwkMaZRZWjXqkTjUwHinLZysyNdsyl0lxFjjXSi
	MwL3vQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4ebprv20-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 05:54:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbe77d6864dso7216530a12.2
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 22:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787032454; x=1787637254; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TbCaoRP4jgmLhzxgTcurQvCQNdUxxOfgWCAkLYtazKo=;
        b=Hzu0IvFhZXlmXF38FDPkfZtsZodQbjEaY2gfTRmb4aswLUtUFubRKbKkNOyjd78D84
         87lwYU7VbWEHxer9JHxR/hddJ1foN9slbAzrxKc30bUMvCHtT4WRHlmPgxsJGXMGiPRv
         AH16ovEegosDT2XQxy9uqcIkPsC2likuZDn88+dk19owe3cstRwKx18FIhVeJMz4Q3IP
         GTbFrWEpBYQmoYeVqRjMRQOYMOIzHlWirprJ9IWE3PgsXysteuEPYOvGWfMraKPgX8Vt
         2Z9HewUJiQL67x1Neigd6fqRqXTqfoi2tw7oW6pbWJEcbWYvb2o+4qa5Er1T4WtWTak2
         IEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787032454; x=1787637254;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TbCaoRP4jgmLhzxgTcurQvCQNdUxxOfgWCAkLYtazKo=;
        b=SRs0Us0H0MOnYeu3KSTgnp1b07XMMYLEhR6emsng8vQ2Ylw/LW/0TMB9RdbGfg17My
         dT99PCF/SY0CRs9avQl3rjAH8MO7BspvYIg45px3OBZAGQ0Na4jCXhESZKobOZD2keaK
         9D1784g4S2QZwpo3O07bwOTCMBqnDlbW7on8Kz1FTPSp16ZHiyXxlAvlRqYQl6HT2oXq
         adDUpWGGQvkWMxi9iQjCG1J5SCcLen4g4+sGjZF+50BwU11t6HDuhsE9g7f5kurKXDrb
         mjkLbp2is3bVd6XQxwhq7fPBxODi92JC5Q4wqUB1r7GI71oNWe+muoaINT07tha4T7Ey
         5hBw==
X-Forwarded-Encrypted: i=1; AHgh+Rqma2cbSb6+ELzSR15RsWSJTHWeTG4Rzl3NM8G+O1REAK/XeCB4OueKYBFAGk80HFzzHP8+rw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyahjvPSweh0bUcHIDA12CE/mXFGHcGMvD0Mh4NHrNW3WoeH35g
	xeo0/c72UZ9OZaugTjbCXJJT0fyXnPoZ0mnCKqnZZJ6zTIYXT/1CRAMZw5weJ3tQasPpLQqXZpE
	cumyxoZdC6YcbQKzAOT1H2iJpuiMa4hECkv9xlVnWAUE/I4935jV/Oiz6BA==
X-Gm-Gg: AR+sD10VTF4EZzcOedG+1UMS5ndXi5ULzisxRzSR7LvtWox2BsGeqPFZ3NqKDpkjv+e
	P6yqJXji2ZswIbz4dMcrIg2HxvOicCLhec/nkAIostd9xwzQ8Tn2HAf+woYbpzEBMkLGTWYlQGh
	2h/hOct27xISweDQM9Wuk6rRNbI+raYGRziSzXFS0ousiFDtRees7/IL+rgHOXzUZZxIDvcdyCD
	UdwxWgm2IH5zexVI3v6hcyjFiv3s8eclx6D0RW8gPScE1z04QCXIqVVdbu3nOZGCfdvtgscvkMU
	nJoOYHJQOdFe74kfKMrI7y9zCtZMdOdYsDntS8eQjwIEAn4/qYPxhQhROE+zr4/IgTQ8lm93rYY
	SwO1A4kW00ybkWnTnyki2zdp/szuD+Q==
X-Received: by 2002:a05:6300:141:b0:3c8:e10b:7a9b with SMTP id adf61e73a8af0-3cc71b19c7emr37663917637.16.1787032453948;
        Mon, 17 Aug 2026 22:54:13 -0700 (PDT)
X-Received: by 2002:a05:6300:141:b0:3c8:e10b:7a9b with SMTP id adf61e73a8af0-3cc71b19c7emr37663839637.16.1787032453547;
        Mon, 17 Aug 2026 22:54:13 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc13bf26a0esm1592712a12.8.2026.08.17.22.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 22:54:13 -0700 (PDT)
Message-ID: <376e0fa0-c863-45ae-a8f8-6d4b74ef0b8b@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 11:24:03 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] accel/qda: Add GEM_CREATE and GEM_MMAP_OFFSET
 IOCTLs
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
 <20260817-qda-v2-v2-10-69a02e9090d4@oss.qualcomm.com>
 <tjfcsz62is33iphcwtensnoiohhpfk2zh43qfe7ijd4b2324pk@v3piffq646ac>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <tjfcsz62is33iphcwtensnoiohhpfk2zh43qfe7ijd4b2324pk@v3piffq646ac>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ue7jMcAlJ17vFjsrkv1gOeLmHG349koy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0MiBTYWx0ZWRfX9/tPnozh2JCy
 wtEAzypxl1gLLwQJ0iawmgGv5WPPxK/5w11RobuBaZz4ALMqp9YBk8/ArqwdDNYf6Bjmeixsuhn
 Ow1x51ww2jYNnoMgTE4RAQcFCTerjEGxxc/WboQeKn9JyKWE0QQCF9PE3NK3/jtVwldYd2DFibd
 gZ9vMt8Gw7iXMvlTxxjCq9i01W8mjmwhYBKl3ztProeKv0A1ZOHvculVNT+bFGBxMRjRcePr2/w
 W/xlbIhCmyfMOj6Zavx3OhDzngDqWqtfvfUQN65Rz/h2f1MieXr1Fd5DaxunCY53YikLDHfWRFN
 c6Z/SxIM9F71ldPmWKEIH81yCnRM9LayF4U6EYyJs/QfiKhGeH1jlHwT1MhAb4mIwPnZSYBpNr9
 es8UPUGt9lQdaZLfFp6+6DVAq2xKiN6SWi4wL4g5lrR4Py3EvPgrwOCQatuMxr6nH9eANMiWFCD
 BdvJtqQo30iuGmMtoqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0MiBTYWx0ZWRfX7RxBphrJ29rf
 0BXd8n6TYn67ci+vPk89qu0zxxhOpc7AM25yuErWgPQoWc1vTvGYZbqc50fGPvY2tFLDbemXZXn
 brf0f7QSikepX73rMZWY/Ng+uGdWCao=
X-Authority-Analysis: v=2.4 cv=FsU1OWrq c=1 sm=1 tr=0 ts=6a83f386 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=cA8Zc-eO91vsJqbwH70A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: Ue7jMcAlJ17vFjsrkv1gOeLmHG349koy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180042

On 18-08-2026 09:19, Dmitry Baryshkov wrote:
> On Mon, Aug 17, 2026 at 10:17:45AM +0530, Ekansh Gupta wrote:
>> Expose two new DRM IOCTLs that allow user-space to allocate DMA-backed
>> GEM buffer objects and retrieve their mmap offsets.
>>
>> DRM_IOCTL_QDA_GEM_CREATE (drm_qda_gem_create)
>>   Allocates a DMA-coherent GEM buffer of the requested size. The
>>   memory manager assigns an IOMMU context bank to the calling process
>>   on first use and performs the DMA allocation against that bank.
>>   Returns a GEM handle that identifies the buffer for subsequent
>>   operations.
>>
>> DRM_IOCTL_QDA_GEM_MMAP_OFFSET (drm_qda_gem_mmap_offset)
>>   Returns the mmap offset for an existing GEM handle. The offset can
>>   be passed directly to mmap() to map the buffer into user-space.
>>   Imported DMA-BUF objects are rejected by drm_gem_dumb_map_offset().
>>
>> DRIVER_GEM is added to driver_features now that GEM IOCTLs are
>> present.
>>
>> Assisted-by: Claude:claude-sonnet-5
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/qda/qda_drv.c   |  4 +++-
>>  drivers/accel/qda/qda_ioctl.c | 50 +++++++++++++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_ioctl.h |  2 ++
>>  include/uapi/drm/qda_accel.h  | 36 +++++++++++++++++++++++++++++++
>>  4 files changed, 91 insertions(+), 1 deletion(-)
>>
> 
> The patch LGTM. THe commit messages needs a rewrite
will fix to commit message, thanks.>

