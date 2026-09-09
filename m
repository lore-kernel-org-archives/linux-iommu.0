Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DED46EF92
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940956; cv=none; b=XJiweSt6ZQ8sWJcYOB39XBRW5F5GMsgyL0PBlpCp0au5FpiH8+qbQz87SvHTsd91FO+9Qal6xjsQ28pYNc2fSiqD3/Adj7bOugSetuG3WpT34wQqo5lvYtIRVkoAmFhtPxKcv4MhTXpShpZ3h6UBCDB8j6NnVS5iDlnnSkWhWsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940956; c=relaxed/simple;
	bh=zDuQWKjFE3DA1NY7qbs8j9W49XMYV2fstg2LLl0QS1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqOjhephXyVs9DirhYeOMKwnIydvtrwJMXAij/G5OH18jLuvUQr7nMm47k4qxo8DB+cGW8tWtBjKn3tDVK/Q1Stm60/YaOfo6h1oQlUtfuEF5rzoZ8f7SoGK3nD6CaHdmu2tE7rrtHYhxB379Z3r1HFgk+WIsrsOjXCXK4rUxOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PHYMzPk6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FctCEL1v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PHYMzPk6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FctCEL1v"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6896ZHw83817343
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 08:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XSMHZUD2b2UJe3yPgP/kY+F7XMMhsGVvoGqYP6DBmQ4=; b=PHYMzPk6+E474nh3
	z524YrgoQy4kEv7pHq1xxG4rAulORuiyo9L3UgMBT+OZtyExRTBfPC4xfnQ08uES
	iDOKWmz6W7//m9Lg+K4aEbKAyXB8TmZRRHTTBUsyn6eKR/OEaHcASA/A4B6AtWxO
	KrCMVrNk0H7p864zRSVJDm9HRNF21hZ7piVivW4J82MeAVj0IKnt0z3WhKG++8n+
	vhiUtWWtpa7P71MrSCUKCdFSBc5RE7/Pt8hzDT3VuPbWWJ+Qz+8SQwWDak9yh7eM
	XQe9ABJvPVPOZ7wt1dcGj/WXzPldVlxK1JfnlvOUZ6YhdB7eQ3ADI/rl4EhP3DDH
	+XcvDg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjstua5h2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 08:02:33 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-97e99aaaa6fso353171241.3
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788940952; x=1789545752; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XSMHZUD2b2UJe3yPgP/kY+F7XMMhsGVvoGqYP6DBmQ4=;
        b=FctCEL1v73ccWweXcAEdS37GUaEbd2VVAx9LHLxmkUA5vR+CgkSCSnZZQgNYLtgWAo
         TYll+okaGwcSjgxVF2JEN26QZfGhIo0+jmadPWvyNPucBQfcJWhIzHiGuAN0wb3T9Vwc
         lkTvd9vQZJ6gL53FLogRKDi0cRl7ana1IiMW0dhwncBlUU1d3UCNPiS4pjXUuJjdpB34
         N8+G+TDKg15OS1TpbPFXkLRwGn3ZoOTHZahfYIRqlrxeCXvq6MTceKLCIYV9+BC+UGys
         sPoy1wWsieZKX0KjKDq/E9C4b9FdcRgzBIgG+ps1l7FkhucKR2YYX7Y48cN2Amv+JLtA
         szyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940952; x=1789545752;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XSMHZUD2b2UJe3yPgP/kY+F7XMMhsGVvoGqYP6DBmQ4=;
        b=eU2mBjVaIHSHMi1KQGwCHccyoM2DoYQrlXKvoqWMkJ9U5fPPKGjOyMr5WjEciKz1Y7
         Z1he5s/SfMHeTuRxRY352KvjNaxkIvWGZvvlwTKSq+AbWjrXS63RwtHQbEMEocM9+FIB
         7Zi6siz7y+g4aZK+53ZpIhEDVTlVmMiJTWaRBFamQyXRhgYLpKefLR0vgn1+/waqcPYO
         BOq/dSEKjr0q0w8CDloqVs4U4R+b1L8BYTJx2n0oSfOG495lp58QdRrhh6M2IPWZt4i/
         vTtwt8B7+t5l+Pbl8aRFAxB3y73O8gW3iPJ/5sgq7mCr5T2ROb6TqRwCnsJvp4b4AruD
         FDFg==
X-Forwarded-Encrypted: i=1; AKwUvBy5I+RnbXM15+CRQPwgTF0zatwc/U7kD+bpKhV4Wk/8jwZIby3CiGmtk66LoEmmnG2hinIjbw==@lists.linux.dev
X-Gm-Message-State: AFuF++mp9by66Tdi142XR3jtsPy6ZpLUPaP+VjfGAWYfaUPaVebV51qe
	OZ5UrdN5wZAw9UmF49n79jt3UConuqjbBM3CC78LDQ/Nm2gIkDXa9LIOxbLBPZkFk9pRFVnIuCa
	nKcYjqY1HNBME0QkILZaH1rnSRolG+v5IY/jyH9riv2mrC3QUEhNXu38gjg==
X-Gm-Gg: AYBFou2cCzCTpcq/QE42pyxFw/7vrwP/IedeOUOFPrCBTwJNOqIZ4TCkOyg3CipWNBQ
	fYEVEfk57YeGkGlWN798ifsEJU+n6T96SrGksDlo4kPmW9WBugP3wJk4epJBLxQDW9dieirEGzZ
	eV4mubfP3JkcrFwqEAvD2xKgxp+lO8u6/nw+z+MXTp5fpXfGpqlNGAA3N+ip2izJxwU/45j9UCl
	XjAKi964dSXpvwHIaDah/SV/t+eeR7St9ZkJd13StsEBNeiNA3FigJM1jLV9GuU79T3TLWRfjpV
	6wW8sERUUleZ06tkN3DOehJsLcipwZtH1ckBmeIvU3Gl5HyC0XaYHIT6yfRDoYe3xv67G6t77SN
	e119nx/9z+Cg+IcAKc83VbYDQjhQ=
X-Received: by 2002:a05:6102:a218:10b0:78f:f234:75b9 with SMTP id ada2fe7eead31-78ff234864emr445488137.0.1788940952038;
        Wed, 09 Sep 2026 01:02:32 -0700 (PDT)
X-Received: by 2002:a05:6102:a218:10b0:78f:f234:75b9 with SMTP id ada2fe7eead31-78ff234864emr445466137.0.1788940951571;
        Wed, 09 Sep 2026 01:02:31 -0700 (PDT)
Received: from [192.168.68.120] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c260d5277e6sm707351266b.27.2026.09.09.01.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 01:02:30 -0700 (PDT)
Message-ID: <c447c7ef-828c-4fda-8e82-6983a3d0eddc@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 09:02:28 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: rob.clark@oss.qualcomm.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
        dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Anandu Krishnan E <anandu.e@oss.qualcomm.com>
References: <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
 <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org>
 <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
 <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org>
 <CACSVV03ypjBYkhRpt=TyDwOKhejKKke3x=Fi_TvxXN-5U_rCsw@mail.gmail.com>
 <fb834ae5-7113-4a86-bb84-ca5115c8d7ff@kernel.org>
 <CACSVV018jB4WRRJ_CUHQmkHXZcqauWJXWGgrzY_HA6cFQ+Q3Xw@mail.gmail.com>
 <dd3da35b-1db6-43a4-ae1f-35620692f51f@kernel.org>
 <CACSVV01o_XYuSzaYGbo9pY=459qiA_fgL_KRHVJH+LH4RYcMzQ@mail.gmail.com>
 <23e31249-cce2-421e-88f7-1a2af66e34b6@oss.qualcomm.com>
 <aqCKgM1yCbWjFdgO@baldur>
 <09f62d84-18ad-4d7a-ad18-9abccfd5e508@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <09f62d84-18ad-4d7a-ad18-9abccfd5e508@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ItAutr/g c=1 sm=1 tr=0 ts=6aa11299 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=RSJrEcLJ-t34lzZDKPUA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA4OSBTYWx0ZWRfX97LqWdUqIPN/
 19CpCitv626YVymQUwTVeAmpcEvQofwaCuR8HgHj4UblIjzd5q/9+sxkMdJM0fmixNcmFE84QI8
 AWBwTJtwEPm+ATia5OQUk2gbemd6w6Y=
X-Proofpoint-ORIG-GUID: AnOMpG3WU1mD2cNPdswZ146gs5gV2Z6W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA4OSBTYWx0ZWRfXzarhf/JOC7UC
 DnF90glhhBYiLxJ2fUZeMuzuUfQaSyzMkugvBbaJ78G1V01b8oCg+JP9Sg0OrqW7DRsqjWgebqs
 tfY5o/IYTvT0JWZCSofL6V/5qHW+syO4LiD4Pcz/Yu4ZfaBCql1j69F50xHO7WjODtYeDOjbwPd
 a+BLoDYGpEHvAJabgkfJBf+qCfuIzCvypjAbENAzRjuyNvR1iHxGcpotcQLtbMKwg0lOaCRl8Ey
 25TSWuiG2dSaMLLRJmtlynwSr394HHNDWVof+sej6gS34PRrjkVyaV64okA2b/6WiMc4ei6xziK
 RcVze5nN3QGew45h1R072WTIhjtFB99XlPmcsN6WjiKuAaLAUKaUOZXNwWfvhbHO2eCIsKhk1IM
 aQeXCS1UsfpqaAlveGylQJnJqu38cpqUwOhS8ITiMcbT/QZnT817tkVo0hJUoPEQyDHNKNB3+WL
 w/c4AkvKHvtlv1SPpxQ==
X-Proofpoint-GUID: AnOMpG3WU1mD2cNPdswZ146gs5gV2Z6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1011 impostorscore=0 phishscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090089

On 9/9/26 8:53 AM, Ekansh Gupta wrote:
>> This is the actual problem!
>>
>> We have existing user space that depends on the ioctl interface exposed
>> by the current misc driver. You must not break these.
>>
>> Hardware cutoff is not a viable solution, because that's just a
>> declaration that we'll let the old platforms rotten - or alternatively
>> you commit to maintain two drivers to the very same feature and quality
>> level.
>>
>> So the only reasonable solution is #2; from there it's a valid question
>> if you reach that point my stepwise migrating the current misc driver
>> that solution, or if you present a new driver with the fully backwards
>> compatible interface, alongside the new ABI.
>>
>>
>> But this does bring to a question which the cover letter should explain
>> - but doesn't: what problem does this patch series actually solve?
>>
>> Regards,
>> Bjorn
> Agreed. I'll target #2: QDA implementing the existing fastrpc UABI
> alongside the new one, rather than a driver split by platform.
> 
> On how to get there: the blocker we hit in v1 was that legacy fastrpc
> buffer semantics appeared to need a drm_file, and there's no exported
> way to construct one outside the DRM core. I want to re-examine that
> constraint rather than treat it as final, since the legacy interface's
> own buffer model (a dma_buf fd as the buffer identity, no GEM
> involved) is not inherently tied to drm_file, that's how the existing
> misc driver implements it today. I don't have a concrete design yet
> and would rather work through it here than commit to one prematurely.
> If anyone has thoughts on how the legacy UABI could be served without
> requiring a drm_file per session or if I can somehow bind drm_file with
> chardev by exposing some APIs from DRM core, I'd welcome them.
> 
> On the cover letter: fair point, and I'll fix it. The problem this
> series solves is that a miscdevice interface requires us to hand-roll
> what the accel/DRM subsystem already provides as common
> infrastructure: GEM for buffer lifecycle and reference counting,
> PRIME for cross-driver import/export, per-file (per-open) context and
> handle-namespace isolation, and the existing debug and lifecycle
> tooling the DRM core already ships. Every accelerator driver added to
> drivers/accel (habanalabs, ivpu, qaic, rocket) has taken this path for
> the same reason, rather than each maintaining its own equivalent
> inside drivers/misc. Building QDA directly on this shared
> infrastructure, instead of extending fastrpc's own ad hoc buffer and
> session tracking to cover the same ground, avoids that duplication
Am sure you must have already tried this, but Can you not migrate
existing fastrpc driver to this shared infrastructure under the hood?

Can you elaborate on what are the blockers you hit in doing so?

This will ensure that UAPI is retained and still get benefit of QDA.

--srini
> going forward.

