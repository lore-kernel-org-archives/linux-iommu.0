Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32A385503
	for <iommu@lists.linux.dev>; Mon,  2 Mar 2026 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442532; cv=none; b=oFMy3jyPWX6H/grupHdwsc3mQNRSwmzuGdl5uaNcxtfDTw5vA+PewYK8pK12TfmI5Bz6iP/GJhjIyKSrDDYKx+3iYD86/K2OsZGnGfiPwM5vk1CSlkId6WeB57FKz8cwqlbOOzPY3ZKwHCv1isRlRiO+NhXme9BhrhbYKiiNLBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442532; c=relaxed/simple;
	bh=m79/X+bzTpXZL9AiiyjJ6wo5Md/bncCfMY3V5a10w4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqIclxCxWaAwbatlTc5bG323lIOHqMlTsdEkJnj2eEslNWJg802acI8+Yrtk261oBkS6VGDGF4c6bDkcEoTjf9BNaZ6llK5b/05lSSsOBdFMP6+xUDCWBLcceFPupSshCgrGNeO96hMxEGmU9XWLpBneWruF9ZY02EBv9M38m9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ls3MwxnS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EREqlp4U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ls3MwxnS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EREqlp4U"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62294rxJ3753576
	for <iommu@lists.linux.dev>; Mon, 2 Mar 2026 09:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gwaj2fAAVlaePOzG7WDXhDqR0zvBqc8L7FKmuItcwFw=; b=Ls3MwxnSvG7BIlnK
	IyfnLH5p9oe0dLepe1a+nqOGmpRu/4qG+sSO2gKmIHFKo06/ya1XPUOlwIW8eJLo
	2pI6ZrmU7TWboPLUzkOpLJrZS0MdecFq3rnqNKndUzd3HTHAzh2h05tEBXCHKNWw
	UUnXHYIFMOHVnoduZQXFCNyXoMdMckQOumOzGjKlJMap5hlsoeJjDo95nd5KKVrk
	MLS5arA2twyVRrIQrypnewUMTD/4e7RD6eerC/2c4QVVBBTiAfeeZg5qDvJoZUCv
	4ZHwYUF9OM8jLqjubqvJqSVdZEqjaym+yMXm0R4xenGrRwgqPN/2Bum3YHPUdqNR
	Hf4F2A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7kq80t9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 09:08:50 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82740181631so1648412b3a.2
        for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 01:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772442530; x=1773047330; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gwaj2fAAVlaePOzG7WDXhDqR0zvBqc8L7FKmuItcwFw=;
        b=EREqlp4UHMdTLjKp7k5ogcmT9Hb4VRhjT6C9av+K845Vma7WxFgzrpnIRpFTQQOBsC
         fylKs73gcpKhIxYr899rPXUNgmcFHwhcNYJ5TxlFA2Zk4wJspz7EkETYiMm/XzDJbh2W
         2ETDSYbnR1FrLiHeUGNZImjdh95Zklm+kjNTkkGthUlKWSy66k9xxuViqD5ZFjnFycJo
         k8a+C5k2+DisStB2v8ApmAlqMUdHbFBKVfp3lEXcZHXJz9fX424SEvqKTyHu+Bn+350J
         Z+5qWG454XXsai8x8Xs7HeUJO8Tl8AKLwl0A5R72zscysrrWRpe7bKRjPxtoWfbGh5LU
         laTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772442530; x=1773047330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gwaj2fAAVlaePOzG7WDXhDqR0zvBqc8L7FKmuItcwFw=;
        b=QS5e+4o77omEuMnqqnU3XcLtudeki0HCQC0VMkqrzH8w5Z6U6D335JFpcU1vfwJJCB
         rNK0r3xMiG3EMWWOsnyOdm8ixeW3M6phIdF+kR36FaVk/m/tq1dpOiE/HAUy1aMFaHmh
         0mGLHMX5FBxp/v1wf/cd8bR1cnwwcYOfR9x86LN/ddSzG3BRjxXYerlgVWlRKtZkgP7R
         zkgqojqZkuJ3UUwLq5VSj3aK9reW7BOr/PSBON4YBe5yixznrKNcX6NBy1fkZ6pHbWYL
         cCNzsbVAAejSz2hCWXchmAmEZjnaZyw2+G2YtbSpm567Wnia508ixYplOyfBgFi4vaaL
         YDsg==
X-Forwarded-Encrypted: i=1; AJvYcCUo/YtwpuqLz9x1jiS+TZ9b/OflWZ26ZJuq9qjHPbsRwnygoW+eq4Jx/uJrMQbJGGZWIouoeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIVMUyVYtTuV89hnGIwQRNUF6cVHdxaU3DzIYoemZqX+nXJmdM
	Jc620hi4UDKMOyTBOxH2M9e794lQNPxFWwhVf4h/3HGSCKD+2fBlb5cgCw0G13mSkgDHz06Et+w
	urju0NU2+dXTtCuChn/7S5rGfZHFfZK7mtpnM2byGSbzn5UjniVagEwQYAg==
X-Gm-Gg: ATEYQzzJIIgVK7tvzJZIDfYmb4YincS3V86i5l0XTdDTDnIdJyE5XJyAjzS8W8igVAB
	YhsRsjA3VlVlMwjqZtjpqylNVwtkKpiHnXpaiyGojmAGF7EIrKg3tyNW4puzkVf8hZdhNP8V6Cy
	qpQeEY3KsudvEuzwt4dsC8m8+X9l6j6MlXt1tMkUcOopldf2n8R3wPgz83ppcjnAvqy5sBlKReH
	rMuZCj2z0G2uWYIJNJAuS2HHNlReI235Narz4iN/41zKl/2fERSsoj5oJ+bf7tdx7+d0jvJVli9
	rdbgLgadC0UfxNbtBLcQOS4Me8BBOFB7hrcYzlUIYy72EXiWdPwve+GA3lE0rKSNVGzDTHhO+Mw
	qwOzt9PKwAc0HiMudnqP0Jn4w3tBlcLxTMKu5kqwEptiW/+OybQ==
X-Received: by 2002:a05:6a00:22d2:b0:81f:5238:5560 with SMTP id d2e1a72fcca58-8274d93af23mr10970990b3a.13.1772442529569;
        Mon, 02 Mar 2026 01:08:49 -0800 (PST)
X-Received: by 2002:a05:6a00:22d2:b0:81f:5238:5560 with SMTP id d2e1a72fcca58-8274d93af23mr10970955b3a.13.1772442529070;
        Mon, 02 Mar 2026 01:08:49 -0800 (PST)
Received: from [10.206.99.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1c9esm13696576b3a.32.2026.03.02.01.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 01:08:48 -0800 (PST)
Message-ID: <a46bd6ea-ec33-431a-bcc2-1ade0b40c5ce@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 14:38:41 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 11/18] accel/qda: Add GEM_CREATE and GEM_MMAP_OFFSET
 IOCTLs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-11-fe46a9c1a046@oss.qualcomm.com>
 <d620fb9b-3e52-412c-b687-4b464615430e@amd.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <d620fb9b-3e52-412c-b687-4b464615430e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mtH7jEDrp9vFtoC7ro_81tTbK0o5oDBu
X-Proofpoint-GUID: mtH7jEDrp9vFtoC7ro_81tTbK0o5oDBu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3OCBTYWx0ZWRfXw56v2ZNG0yNp
 Zmh5k89sC2R5/LuXiqz/1PE/gXooBEHPl+j7YPE+i0QdiMg7hXm1sYbOPLqgqa6RcB/wNXlA5ZA
 6UE3RdnvkJv09AI3QIkKmog2WIT5LAPNDRVIrE4zkI2PJpWslHye2pS9WiKOD8oceHy0iKHOkQh
 yP7CuB0SCRF/hYlIntgfsRmqQZGsmOq43Qbr8+JWcgnCYCdlfHfgIxJAiyHFo0kGspHWWVoIRgU
 BB97pzM4NvUmjQZSYmJgk7SGc3hquk/0JNSfTv6+7xUvSdgB2HuJO9couCpdgOTpDy6s92qokpq
 ZiMJHSDnXlxBgL0Trajq4rP83oo7+TpCRmKZFNjCPPcFxVL1KTwgHPVQZvSD1IjOegwvsaYO28J
 sWeBvcxpORY8iM/8ya/mNOytEXA5p/TXHkN8Lv51N1BBJN8AS6+ruwMqw1+G1KtMrFbWDQAoRLl
 fzLWi256uPYMrORdxpw==
X-Authority-Analysis: v=2.4 cv=GLkF0+NK c=1 sm=1 tr=0 ts=69a553a2 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=ukUgU1k7PXLouMuqi7QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020078



On 2/24/2026 2:35 PM, Christian König wrote:
> On 2/23/26 20:09, Ekansh Gupta wrote:
> ...
>> +int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv)
>> +{
>> +       struct drm_qda_gem_mmap_offset *args = data;
>> +       struct drm_gem_object *gem_obj;
>> +       int ret;
>> +
>> +       gem_obj = qda_gem_lookup_object(file_priv, args->handle);
>> +       if (IS_ERR(gem_obj))
>> +               return PTR_ERR(gem_obj);
>> +
>> +       ret = drm_gem_create_mmap_offset(gem_obj);
>> +       if (ret == 0)
>> +               args->offset = drm_vma_node_offset_addr(&gem_obj->vma_node);
>> +
>> +       drm_gem_object_put(gem_obj);
>> +       return ret;
> You should probably use drm_gem_dumb_map_offset() instead of open coding this.
>
> Otherwise you allow mmap() of imported objects which is not allowed at all.
Thanks for pointing this, Christian. I'll read more about this and fix as per your suggestion.
>
> Regards,
> Christian.

