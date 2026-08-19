Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627A037E5C5
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145483; cv=none; b=F79yAK7dIb0Tfc+HxwPbHpaKqPCTk6zAlR52iMMcJPFX2rTpM01nJFChCDPwIOEioG4Q+QjX/mNexjEvImOqkDMG4sYWiEcyV31VJkh5EkjtzzGNcW6EvbkyGaIG0g3khcQecmwtGldZLIN2d98WU8/mNyjXujOVoi92pCL/9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145483; c=relaxed/simple;
	bh=+dq/mMnDe9QFfq17yLaBK6nHu+80T6tyc8mfK+ZvPkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hL00+kABgT+SXPVZ8flA43l5GcQrPRsGvVvKH+waCWAyVCy5Y7m0FTcDU7EygFTUuuUdu1o82LzXFcfGBIRhwETY6KMdGyLvv0nGfKCLIf7owTve/NeFAenlZVhP8msKUC5RIrjAc55wVcXTnEMyHIoZmcXsI81Mmud1VjviQPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dTR/FC8r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C501jhYs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dTR/FC8r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C501jhYs"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JD0PHa4114530
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 13:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DHcojprWwMclTR96W1Kcp7mAYQX7rnuvUTwbQrssUdg=; b=dTR/FC8rtsTF0qmw
	JN8frrhbf2bjGgTihPM4XakQB12zomE1VpKen0fOtSgG46aHEXyCWFOTuRZKS7Rs
	ErV6+SGTMSgG3cxaldLhHs3QGPdbiyn9rNpTe7JjLbSzMfqopRCRG987PZcfAFP3
	4RMg7P2JPaJrnnQ7ssoi1uBBUtLtsd+EBKmGH2JOp3iaFEp2xOORM+hyYlcjI+LN
	uVpR0jSaAvc19aIOHICGZ4lUAbji2Hanp3LjYjHTNKhVcpF/n17pggSk2jnYp/4E
	l5I7Lf5/9XTlCfsMkCZYDby3WDNf8pXxOLhPUtjSUGqljtRZ+UaznP0NSLi1KdVB
	2EiJDg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfmbbr2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 13:17:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso1172794a12.0
        for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787145475; x=1787750275; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DHcojprWwMclTR96W1Kcp7mAYQX7rnuvUTwbQrssUdg=;
        b=C501jhYsdW3Rs7N93PuW5MtL6uPt4DW4v+O1L+JVxSVh4KO2ZMbSbBcqaPKjjYo0sx
         pSBtK7omDf8+PGpQvrGeSc083rTfThP4AGknnl2TjC81DmTcZBwb7e+pJi6GlxBDxIuo
         yP4UdnahgG65NwbOvFAqXNvsWpX4KSgponWNanmnSv1sZwSKKtc1XUldi1DyyAz72Yyy
         0Wg+ZDWd7o8bN/EeYLUrHMWdatIOfnYUxZoQfut8M1Hn3i9F0QqbDCUu23kKl9lTl1Pu
         Pz67YRT4MM6cbACL3EgkfMCVvX4PmbELqwDK1jmhf4T46PjB4EeXUsIaGDajp2mKKoIZ
         3t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787145475; x=1787750275;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DHcojprWwMclTR96W1Kcp7mAYQX7rnuvUTwbQrssUdg=;
        b=ep6niFLB2VMPsDWHwvUmU+z/T7+tBqRLAnbbUjGZyurOPX/0vMo4DUBz11AtZiCJbN
         8TT6p5jqw8FLI+stQm9PUYaOUWTI7y8NbAA2BITnY2yEmHewBWcmv//crcoFO/KU9bGx
         fRlY6HBKIp9F6cqDi2RmVlZCdywyN998XHQ4dwFjGjHxjXMBVd3jVMwMBaXaRz06aiIS
         6svAkjxI2WVNczGgdm8FqLmUqDPzwRl4Tuq+eLSdwG9nJmOUrAwEUTBXiWoM/If5/5z3
         nFAcotUxEetRO5R11/VpukIk6YY1h5A1jzUDK/kh7k6yGDaZfX+plolwk2b6v30vdxip
         hB8A==
X-Forwarded-Encrypted: i=1; AHgh+Rp+WEG/l4WqNevQhZQLMvef1Vtst4znkPkKLvH8JMXSpEqAK6avq9WyzQ1RPHKRJP927dTH4Q==@lists.linux.dev
X-Gm-Message-State: AFuF++kfalJYRm2fpX475dgh+j379IpEgee0oxB35jRa2qYzjB3pr8Qq
	Em+yhuOuzRZKFYZUk9LH74XdW6DpWi/JEHRCktY128GRSV1fAfJwbD9wsKUG9BHP4RLYbveXObZ
	gGvm+7/h07tJ+kAB7oKmwT/nBfOWTlJ6r6x1OgkkfymxdIk2OSPgMjiHQvQ==
X-Gm-Gg: AR+sD13LIutTPHlbX9Hxm3VpqhpNxkMEzEbzKtp3IyXgjTrKVJ/WkMvtc6xirY86vcm
	eSOK+kLEmC98LuDJfTNm7Gh9CDpa8JxrjvpPwp5GfHK7qV8DUit9xroFxpplbbwPxbO03bw0AzN
	5I6TVvvF4M7K8jyUFyd0N+7aHtppWHtvaA8dOnYcTXE0jjHkl8KXfd9QBYa+XEaFkBoE1aZXA9Z
	qGj/0UgssaWaVlMket/2/HjHCjt7Czm5cLIBKkJ1H/e5pIeL68L5P13tz3RQX9/SQrYp3JtrCRf
	UhoTZP3yBiWeNeNzWJnf5zijfwMOHhTqyXVMnlh8Wbv0MJEqNz98QemFPbZjYpZaeGD+N3hz+O+
	btWoun7wRbX3QJysq7GK1ZzgDoJVuPg==
X-Received: by 2002:a17:90b:57cc:b0:381:a766:efcc with SMTP id 98e67ed59e1d1-395810e93a0mr8967639a91.14.1787145475193;
        Wed, 19 Aug 2026 06:17:55 -0700 (PDT)
X-Received: by 2002:a17:90b:57cc:b0:381:a766:efcc with SMTP id 98e67ed59e1d1-395810e93a0mr8967481a91.14.1787145474636;
        Wed, 19 Aug 2026 06:17:54 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f7c962csm2756751a91.0.2026.08.19.06.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 06:17:54 -0700 (PDT)
Message-ID: <3476b5c3-7983-4994-a901-3d7d8bd75255@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 18:47:44 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] accel/qda: Add initial QDA DRM accelerator
 driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
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
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-3-69a02e9090d4@oss.qualcomm.com>
 <81708487-89ce-4cd5-b39a-2989bdce6088@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <81708487-89ce-4cd5-b39a-2989bdce6088@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwMyBTYWx0ZWRfX/vwBcWn8AAd+
 TTRXnQcmDBQuLfTHS8JORwsak4LdFl9w+3/IkrA563fmhirYNjKGH9HXSBUDm9a1QqWE7pi7xQj
 /NvO0J5fJ0kopIfLrFfPxOfnYDTUx09Xt6+ShsXVDIGKm+zns8WwzFbvGNdjbkyKMs6AvSoft9E
 CsBX6DwHt6LU5pFlv9CihheVOdULgFAgxCHZ4u3jNYWmfULegp6+diLfBqq6rXROTip7ubO41E2
 gqUkczgRy7zRfrOLG27BEyVayvLw12K89KvSb7iacBrPrmfrf4AX2N+z/swwQQWCn+LHPMSQht4
 sxVcOgdGA0RkQXW3uIgIK1LwOcHxBw0J/AATXK4vnQwvunUiGh4oRBqgkTFVZOOqMaVk4GG4/r/
 xqHmKsJX4DgX72riQoT9YNaVG23ZfdXnTNkqzc34Fpzc33Wg3mYD4qd7amn7DMOd07B9qUFfeWL
 EzPQcgPIEytkPYjMvTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwMyBTYWx0ZWRfXwkTK6nG79czI
 dhjeEwuhe6iX4fAnAk5LYf/1DwmgPw13oEmmBH5TtcSYISqYSrzFyYoAzQSoOw0T4lEJHr15bdc
 JxnfaVDB1N8wzieMwAjB1iVaqKAHXiE=
X-Proofpoint-GUID: SdUDZ0EnT-8TJyehSCS0S7VXbIY5sP05
X-Proofpoint-ORIG-GUID: SdUDZ0EnT-8TJyehSCS0S7VXbIY5sP05
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=6a85ad04 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=D19gQVrFAAAA:8 a=EUspDBNiAAAA:8 a=fiCeWNywFvmbcpy1l9YA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190103

On 19-08-2026 00:40, Krzysztof Kozlowski wrote:
> On 17/08/2026 06:47, Ekansh Gupta wrote:
>> Add the skeleton of the Qualcomm DSP Accelerator (QDA) driver, a DRM
>> accel driver for the Hexagon DSPs found on Qualcomm SoCs.
>>
>> This patch registers a DRM accel device, exposing a /dev/accel/accelN
>> character device node, and binds it to the RPMsg channel used to reach
>> the DSP. Buffer management, IOMMU context banks and the FastRPC
>> protocol are added by later patches in this series.
>>
>> qda_drv.c / qda_drv.h define the drm_driver ops table, the per-file
>> private state (qda_file_priv) and the main device structure (qda_dev),
>> which embeds drm_device so that it can be recovered with container_of().
>>
>> qda_rpmsg.c binds to the "qcom,fastrpc" compatible via
>> module_rpmsg_driver(), reads the DSP domain name from the "label"
>> device-tree property, and registers the DRM device.
>>
>> Assisted-by: Claude:claude-sonnet-5
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Use module_rpmsg_driver() and drop the qda_rpmsg_register()/
>>   _unregister() wrappers, module_init()/module_exit() and
>>   qda_rpmsg.h entirely (Dmitry Baryshkov)
>> - Read the "label" property directly into qdev->dsp_name (Dmitry Baryshkov)
>> - Drop the probe/remove/init log messages (Dmitry Baryshkov)
>> - Return the result of qda_register_device() directly (Dmitry Baryshkov)
>> - Clarify the Kconfig help text (Dmitry Baryshkov)
>> ---
>>  drivers/accel/Kconfig         |  1 +
>>  drivers/accel/Makefile        |  1 +
>>  drivers/accel/qda/Kconfig     | 30 ++++++++++++++++
>>  drivers/accel/qda/Makefile    | 10 ++++++
>>  drivers/accel/qda/qda_drv.c   | 71 ++++++++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_drv.h   | 61 +++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_rpmsg.c | 79 +++++++++++++++++++++++++++++++++++++++++++
>>  7 files changed, 253 insertions(+)
>>
>> diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
>> index bdf48ccafcf2..74ac0f71bc9d 100644
>> --- a/drivers/accel/Kconfig
>> +++ b/drivers/accel/Kconfig
>> @@ -29,6 +29,7 @@ source "drivers/accel/ethosu/Kconfig"
>>  source "drivers/accel/habanalabs/Kconfig"
>>  source "drivers/accel/ivpu/Kconfig"
>>  source "drivers/accel/qaic/Kconfig"
>> +source "drivers/accel/qda/Kconfig"
>>  source "drivers/accel/rocket/Kconfig"
>>  
>>  endif
>> diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
>> index 1d3a7251b950..58c08dd5f389 100644
>> --- a/drivers/accel/Makefile
>> +++ b/drivers/accel/Makefile
>> @@ -5,4 +5,5 @@ obj-$(CONFIG_DRM_ACCEL_ARM_ETHOSU)	+= ethosu/
>>  obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
>>  obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
>>  obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
>> +obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
>>  obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
>> \ No newline at end of file
> 
> You have trivial patch errors.
newline problem was already there, wasn't introduced as part of this
patch series, so I wasn't sure to fix it here. I can fix this in v3.>
> ...
> 
>> +}
>> +
>> +static const struct of_device_id qda_rpmsg_id_table[] = {
>> +	{ .compatible = "qcom,fastrpc" },
>> +	{},
> 
> Device node with this compatible is already populated, so this looks
> simply wrong or you are adding a duplicated driver.
> 
> That's a no-go, you are supposed to work with existing drivers and grow
> them.
I'll bring the discussion again here, there was a discussion to move the
driver to accel subsystem if we want to support new features/uAPI
changes. Please read [1],[2] threads. The intention is to replace
fastrpc driver with QDA eventually.

Do you suggest adding a different compatible, say "qcom,qda" for this
driver?

Let me know if you have a better suggestion to proceed here.

[1] https://lkml.org/lkml/2024/6/24/479
[2] https://lkml.org/lkml/2024/6/21/1252>
> 
> Best regards,
> Krzysztof

