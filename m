Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29DF369965
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841291; cv=none; b=BXoSBVwriIzieJvAEi1F+XiEA9PRb3Mt1AflRZ/XDAF8B3jTIeZvmFJNNBd91fDJE/7EqCkxDeQGzBLsCT53qg03WWOkKurSQ3OhVXr42XbnieIEEydSrWfvTLpu/OC9o7b+DZp8GwYECN5bMjEq5fYMZb8xT1HsghHSg60ZoUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841291; c=relaxed/simple;
	bh=7Lk34Za95t+kyvgquAgJFZtmtRJLxGQm+zE5m9tIOeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8WgnKLCGVEsSZFq03MqdroG2DnT9VokP4dNTKthYYzAjauuRDJAIry0IY9VzDDdfdyF29AChuxSUY37TQcxyizqdsWStE4dpGfQ8SF7c1DPrs1thTtH8x98l2vXDSIfXh6pokchHNG9AwrPDRXtp1Hpax6Ght4EurY61rBmjj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J/AEkkMu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cCaZHqrE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J/AEkkMu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cCaZHqrE"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M5OxjD3732369
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 07:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eBGSKr8Uva+BtfeptfpzAP+Zxx4G12UZSHcTVG1Bx4Q=; b=J/AEkkMuXJ4aKR0j
	Q0xfteGZyYNm6QcnqJv2Fyk97Wgj5mZPewxb/aFhHsGhLq6l47ynlhFs21fkqq5D
	5Z7aTz2VsSu3Fu8CuTDMI0BIelyo1kLA8epiLnxRybG80m/AnW/Eh/0xXfKIIIWk
	x/rhjoUt9lsQ1thunmJzMgFfN5OyTKDhBRdhkTBrqeGrK0B1roDrE1f7sZ48CTbV
	7SagRQwG3suU1UaoOOEQI0yZTKEQ1VC1aTcGoS+Dpc5gAJu7sHCd7u3sV77mLtNV
	YoLsMHzYU7uWQ1RmA7Pj4gnz8UDoeeFqqO0h0YTI6O38AZWjH+FPWGutQl5SIEPG
	I7jucA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenft23m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 07:01:28 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f2138a9e0so3053189b3a.3
        for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 00:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776841287; x=1777446087; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eBGSKr8Uva+BtfeptfpzAP+Zxx4G12UZSHcTVG1Bx4Q=;
        b=cCaZHqrE7k7VrkCE0CXXBevKiLOcZv8pdMugOjOwh2iCKuuEnCLVpF2q/dqMvTaL8R
         Hx5Whd3x7oQyhlUkEja4XmrYFT12YGHkSa0oJB5VPtwiz4Vaz2IUmx9JvAuOSJqtxaS7
         1NOlfYhpmu4RYF0MUB+Fjb+w5xZS+7WLOV0wyoBL0Vjn3ZY5ZrnTEs9nzoDKhO/BLgqK
         ngAxyG1EDlldF9UldlGdQROTSVRk/eDpE6qbltj2DrzPh7xp1MgqhwRTJSpBYAPl3fYC
         gURx1kIMcA+4uNTczy1KFA+t7SJmWhqKxkGzWimE93Vi4wcb2T+paBJx6x5dBeo8ks1G
         vxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776841287; x=1777446087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBGSKr8Uva+BtfeptfpzAP+Zxx4G12UZSHcTVG1Bx4Q=;
        b=AOwOkzDqPvHGnli6zhjIWQaMaScrlR0mli6LD8owro7QXQKyvVSg4DflCe++Fk8HoR
         YdrhkgcoIkbhkw3VlQRKD3QhdJzPy4w+I0lziIqPqnL1ar4SIc0Biz2Vh4mfvmctWL4C
         nCpatA63rQILlCA0DZt6lNJJqiO/H9sf8e/jriQVPNA3QEx55SqKTwLmPlmJE8umwN4a
         /rD8x3l9vqFyNl1D7B9shTrM3948480fzQHAe8J6tz3ZrbxgC+qhoaK0p5R0UzZ/VjJf
         81krE6NBtOtnG80SZFT8YuH8omjR6hEFgX5i6YTGeCR7drkp5llOGrCL679cjPWLN4kN
         DB2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8sShNmNUUxaCxbHbHl2prRrHXUkOd2CC+QKjhARz8Cw6cOEgtHwqys3zqq1P7fapFCYk2jRA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxne8bYdWwytSZrHqnQwLqlPkbXu6pyCWUjPZ2/FP/BrEqtX4CV
	cW0koZfCiEwo3Y5gKGUwNC5owWUmesBky3GF1B1VfVTsYdwEbBMRmHqPiNOoJ+MwApjwPy+fQ38
	XRvBj44Y+bb8k5IXsHZL67R36FahQcFQmX4qbJ02KnYNmW92pKh2SwMXxrg==
X-Gm-Gg: AeBDiesROqo2ETJBC0M/uFRso6Y6wI98dLIwG3/+xO6xTjEU0TnoVvNdILNg9dlRfYE
	dVmvN2HwDaUen3hsFl65fzGCfdjLtBQm6A7/Y14rNxL9bVjqOf9txztwAQOA425Dyzp8erMwNOI
	fuhO0LPPcGlFmjz0z9HP2Z3F06qqOOleprfOCZ7eZUKVmtCxyb5yGAmZIwEUhx/JYfoUtzTEJsw
	ELCfsrRaCo2Mq5y8PlJAqSRWFLri3jQBjb44296DqJdH4frL3rG0sh1kpKTH1tDXUa04ymZcR/a
	mHbEsL2Hka5nq540iL+N08MMoePiKviYSsiH5RRm8rhz5Mj5Kwcb/9LBdrALtyikak0Ef0rs3vH
	DVSlR22so1EByBbtFnCCBGEogNUVtrrpVdWu6oY7kQrX3pd0xgMCy9lhUtJBcBdQR
X-Received: by 2002:a05:6a00:22c5:b0:82c:e670:7691 with SMTP id d2e1a72fcca58-82f8c9300ebmr22580047b3a.48.1776841287488;
        Wed, 22 Apr 2026 00:01:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:22c5:b0:82c:e670:7691 with SMTP id d2e1a72fcca58-82f8c9300ebmr22580003b3a.48.1776841286814;
        Wed, 22 Apr 2026 00:01:26 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981d00sm15665619b3a.5.2026.04.22.00.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 00:01:26 -0700 (PDT)
Message-ID: <077a99c2-c954-c5e6-3699-cd0360e8b9f6@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 12:31:18 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] misc: fastrpc: Use context device bus for compute
 banks
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srini@kernel.org>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
References: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
 <20260414-computebus-v1-3-4d904d40926a@oss.qualcomm.com>
 <cc90c55d-c93a-2789-f313-aaa5e4090be2@oss.qualcomm.com>
 <r25ibbsw3flfashrp4x2cqy6thckgez5k3gtfqp46dcpbjniev@s4ngoa46ekvj>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <r25ibbsw3flfashrp4x2cqy6thckgez5k3gtfqp46dcpbjniev@s4ngoa46ekvj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cYYYlDM02LQG3zEtCJMZ48o_9rOBxtTV
X-Authority-Analysis: v=2.4 cv=YJuvDxGx c=1 sm=1 tr=0 ts=69e87248 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=N8QG227OEIr4kTigVUgA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA2NSBTYWx0ZWRfX7nxFJPnQw4Ju
 HURm8Tumc6Q4SlffjAs1rd+6dWvYh7aFmGgJaY40ytlsXJl01Zo7+T3zuQqzKf8NKpieRCn9hDL
 dRWR4B9EWcnRGEoCb6J1xIPONpsqti9MolepFdpvqQnuyQgw+q0xiCosc7MNCLS7I7Xp1ys7gCb
 siDavwMX0DbZPVVFVYA6UgvHX2E4QjthxkTvWxoHhb4HCNE19GZuBymPPVQnChIsne0sKPNUjg/
 Mc28X4ELwRuP+Crsev8p8pA0zBAGxaiZqHJDcBSdGRN6Bbk/GMOgUdNlpybgXn6eARwXXYutzV7
 8Gz05ztC2mBtwSUutl00JJgSfp1sZDCHXup5WNxTOupFFQhDkrTq3AWNCJADYKCtbyiTLmIFy23
 oNCRSshgF1xG2XYy4YH1PpQLVfY2lpErN5UBGSgBImIwDRqlaFzf3MoBHXAZYvI0PyTzqEZQzs1
 tvavt3OgkgOAe7tyIpw==
X-Proofpoint-ORIG-GUID: cYYYlDM02LQG3zEtCJMZ48o_9rOBxtTV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220065


On 4/19/2026 5:46 AM, Dmitry Baryshkov wrote:
> On Wed, Apr 15, 2026 at 09:35:47PM +0530, Vishnu Reddy wrote:
>>
>> On 4/14/2026 10:01 PM, Ekansh Gupta wrote:
>>> Replace the platform driver approach for compute bank (CB) devices
>>> with the generic context_device_bus_type. Compute bank devices are
>>> synthetic IOMMU context banks, not real platform devices, so using
>>> the context device bus provides a more accurate representation in
>>> the device model.
>>>
>>> Currently, fastrpc used of_platform_populate() to create platform
>>> devices for each "qcom,fastrpc-compute-cb" DT node, with a platform
>>> driver (fastrpc_cb_driver) to handle probe/remove. This approach
>>> had a race condition: device nodes were created before channel
>>> resources (like spin_lock) were initialized, and probe was async,
>>> so applications could open the device before sessions were available.
>>>
>>> This patch addresses the race by manually creating and configuring
>>> CB devices synchronously during fastrpc_rpmsg_probe(), after all
>>> channel resources are initialized. The approach follows the pattern
>>> used in host1x_memory_context_list_init().
>>>
>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>> ---
>>>   drivers/misc/Kconfig   |   1 +
>>>   drivers/misc/fastrpc.c | 180 ++++++++++++++++++++++++++++++++++---------------
>>>   2 files changed, 125 insertions(+), 56 deletions(-)
>>>
>>>   	}
>>>   	dma_bits = cctx->soc_data->dma_addr_bits_default;
>>> +	if (cctx->domain_id == CDSP_DOMAIN_ID)
>>> +		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
>>> +
>>>   	sess = &cctx->session[cctx->sesscount++];
>>>   	sess->used = false;
>>>   	sess->valid = true;
>>> -	sess->dev = dev;
>>> -	dev_set_drvdata(dev, sess);
>>> +	sess->sid = sid;
>>> +	spin_unlock_irqrestore(&cctx->lock, flags);
>>> -	if (cctx->domain_id == CDSP_DOMAIN_ID)
>>> -		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
>>> +	cb_dev = kzalloc_obj(*cb_dev);
>>> +	if (!cb_dev)
>>> +		return -ENOMEM;
>>> -	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
>>> -		dev_info(dev, "FastRPC Session ID not specified in DT\n");
>>> +	cb_dev->sess = sess;
>>> -	if (sessions > 0) {
>>> -		struct fastrpc_session_ctx *dup_sess;
>>> +	device_initialize(&cb_dev->dev);
>>> +	cb_dev->dev.parent = parent;
>>> +	cb_dev->dev.bus = &context_device_bus_type;
>>> +	cb_dev->dev.release = fastrpc_cb_dev_release;
>>> +	cb_dev->dev.of_node = of_node_get(cb_node);
>>> +	cb_dev->dev.dma_mask = &cb_dev->dev.coherent_dma_mask;
>>> +	cb_dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>>> +	dev_set_name(&cb_dev->dev, "%s:compute-cb@%u", dev_name(parent), sid);
>>> +	rc = device_add(&cb_dev->dev);
>> device_initialize() and device_add() can be replaced with single
>> device_register() call. You can refer the below patch,
> Keep in mind that for several arches device_initialize() sets the
> coherent_dma_mask. So one should set coherent_dma_mask (as it's done
> here) after calling device_initialize().

I can see that device_initialize() sets dma_coherent flag for several arches,
not the coherent_dma_mask. The final dma_coherent flag value is updated later
in of_dma_configure_id() based on the dt dma-coherent property.

Setting the coherent_dma_mask here and calling device_register() which will
call the device_initialize() won't change the coherent_dma_mask value.
Please correct me if I'm wrong?

>> https://lore.kernel.org/all/20260313-kaanapali-iris-v3-4-9c0d1a67af4b@oss.qualcomm.com/
>>
