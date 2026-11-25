Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795574968;
	b=Vtq6LyHiEtUHBYCv4EEeCT2aXqWU/5iCCFE2Ve8BS4zbgMX3xHy0oq7RYZnbt3Wy9yUQ
	 mK/+x3zUh3QHzcrlyNWCg550UKEhvb5f2yhGfEv53GRotikDJ1m4eK26pwd3kY3FEfke3
	 BM4E1rGwREC7Sf9a5hUt3LdOrSwJzpW4ODbhWbOhf07iRStudADMeFKB7Rzsdr+Yjdhpj
	 4OnYTXerecTCG8w531Esyc1wE/JDF7NFymQxn6NEyLkiHYNoJsODFXC/hIBfs3vNxSUAw
	 EcMHtL8ueeT4oosCyV72liaSJa+Qyj4qxqjAfb7z8p0TLlsLzkM7cLoVym4LN9RDqaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795574968;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=almGU0M12O3V1h/XU8fpumV3vMxLnGqRFrnMScmHn+c=;
	b=w/AjvgZDWCKvP3gsGQSIcfKqeE+1mGbuaKvUeK9BN+OAgXZE8FN892EF18RJ+zYyaZa3
	 epAuSsKPFm0sx9Jr/yhOCU1Ttt19Uh7fynxUofzEra1JPX6PbHZI2HkdQhhW75WoZmRuG
	 cnPIoZsrY6ZsBFA5I04Mt1rWRxgqxERSi4LAN6P4eUEroCB/5sgdB7PyvORww44mEeDGW
	 jGZN2dzieemF51Q/GrbQmez2Lq496519NZOXHkYjRXkB/yUyliLqS9R/k70DDTd+eNff3
	 w1jFDI42L25PJVRpdn27NMLwgnzIzQXaTFPYVCGcYZrNAcIOstcceoyZZgX3mn7mcBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QcUTFiwH;
	dkim=temperror header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ixKUlYCz;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B1606A32E
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 02:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 895B1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QcUTFiwH;
	dkim=temperror header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ixKUlYCz
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP2AtJ63974151
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 02:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=almGU0M12O3V1h/XU8fpumV3
	vMxLnGqRFrnMScmHn+c=; b=QcUTFiwHsxIPWbmVGqKC6+D2A/CdxE+d5pgUT1ZP
	fSSH7rJFZ2aH2xxSBSwrsn07rqgeH0EvX5UeyHmAZIlN2zzs8keG4RE+IYJRE2SB
	LstqzaUeyiMKYGtuObjEIm3hJ2GfdX9NqYwtJ3wTVAAMZZoqs7t2JMHriPNnBWx9
	3oMAOHYHNSZkHOGiZgedgg79K7A7wP79ZrNf7ZsWXAZI9biEttUfhtXnlwcs3vyr
	AgxYOLXB3tMcAr+FIJWBpMfNSrVOdzZGqYwAlUuGnVsKLV9DpsUGU/Ry0Nqxl9pq
	513W3O9w9/NV32ye+jlCJo0IIVUp1H/0Z/9ABQ9W10/NBQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5n6rrd3j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 02:49:26 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-386ad819860so144066eec.0
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 18:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795574966; x=1796179766; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=almGU0M12O3V1h/XU8fpumV3vMxLnGqRFrnMScmHn+c=;
        b=ixKUlYCzS2/6v/9dAe9Tj6PYiQBSV71dMxuDjOXr4BVdgqxDyJksVGAJoD9qgiN7cN
         diC50l0FsGXwXmqONuH7bTXHCQYbWsB7j7dI5x+usUNx2j7h5f6wcB2ejLZdECOBrZRD
         891mP970kBUfYQQc/r3QOda7bebqlBjAWf8YIdBSoz3npQgC/v0IhILPslm41O/wHTC+
         n/cdCjp8lFeQirzIEm0ffoiHDXJidZ3fKVufrt9aPGM4GjHV0BcVbPAlX1FZHB65MDPo
         QxMkbl4J78sKXWqsEN6bKlzxwsq/hQPUSHVNSSmTmpAimRyXLyy2TwNZWZD92YF9fRR7
         NaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795574966; x=1796179766;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=almGU0M12O3V1h/XU8fpumV3vMxLnGqRFrnMScmHn+c=;
        b=hLm0DSBc8AZUgk7BDDQODVd/0N18eiOIo6CAQrp+R9AIxuWvouDi61hdGRWelrJrl8
         6tOFN17eVB4thxVAzyY63MQTQbRwZJTz/iQOTmoePBH+PND3bWH9Z461MsxI5Nhp0QN1
         pVUZ10R5FP7Dd00qSfyN18uViX48xiTHF9HFZ3npbt9WdzcVN3lBet9wTKTpKwQm/l/o
         thDtwwzcJpZtL93y5E3ISdMHP5r7x8yB/eUYDZBv8fbDQujuEf2Ma2VcMr7utEfMjAqS
         vfX9vdlNXEry4v19cBz6QIW379aNDp1l1t8oTfKCuKe7BGaoThDTvJJorhepSX0XlTRu
         T+jw==
X-Forwarded-Encrypted: i=1; AL+hErHMhKcZ2tIQD2nzfAMpctB/8bNbtPqrRFGHEAUkYGJ+0dBbbzVO+AFHKA0uyzljBpTr8G2Xlw==@lists.linux.dev
X-Gm-Message-State: APuU4Z//0Ua+3qAV3HpaO+fJPrTEaXRJ/Gx/Mx+85R166QBh+NJYBWTK
	iaHieO3h91d2XNCIZeJxrNpDc8znox48YPbcZfvkQVUfS9A92eJ6wUwFaUzP+8dvdoka2Lav+6v
	Rv9yw58WIQLha6ugaunaP765aSIO5vsP7n98VKSiwpATghnTLbqU3/Ind0w==
X-Gm-Gg: AZFdTZd7ut9Kg+TDitQ/9kM6VdKo6HFpmlEmEmJ3A3oOczDMf3Bh+xVftUqy5lLOEEo
	vDelRGoB46zVneeNxyKdvv5LGqn8cz7bKSwX37E3R6VzN0PmG9aNsOlninbzgjJrU1cR8RQwW8d
	N1L2g9tvZRyrDXSp4m5cIurC/UIkYlx9HrFqW4vWamMIADBQ7jdmel5lc9cqLoiNdFI2AjkqdSu
	6Pzjv1pNaXjaUogt58IMCd32gvYd+ed8L3VSB9CgHb9BDdz5eorBMchMbF3Oy46z2qTCtpTiL2Y
	Fn0o14pN1eUUrx8iaRZjWmcw/ytTmtfpBtNRzPsNoOnDe2cbMiFWGASBXR5Z+UtvPf5XTPz6QlS
	9u+7BxA15drAie2FRAr8FTKkd6BZKVVq+dOxaWPh7dLHnjUIOF7YNAjPObR767ic2D1jWwdMh6+
	KEny/KD5K5ICbiwH8J7z/FW2U=
X-Received: by 2002:a05:701b:260e:b0:1a9:c52f:655c with SMTP id a92af1059eb24-1b556900476mr18812722c88.36.1795574965840;
        Tue, 24 Nov 2026 18:49:25 -0800 (PST)
X-Received: by 2002:a05:701b:260e:b0:1a9:c52f:655c with SMTP id a92af1059eb24-1b556900476mr18812707c88.36.1795574965252;
        Tue, 24 Nov 2026 18:49:25 -0800 (PST)
Received: from hu-petche-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm37123698c88.2.2026.11.24.18.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 18:49:24 -0800 (PST)
Date: Tue, 24 Nov 2026 18:49:23 -0800
From: Peter Chen <peter.chen@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Jack Pham <jack.pham@oss.qualcomm.com>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: Re: [PATCH v2] iommu: Hold group references across bus_iommu_probe()
Message-ID: <awZMs6kWUvXnwXFL@hu-petche-lv.qualcomm.com>
References: <20261112110747.1903321-1-peter.chen@oss.qualcomm.com>
 <179520803625.1164516.5819106673711321760.b4-review@b4>
 <awU4DyS7irT1a-nu@hu-petche-lv.qualcomm.com>
 <20261124124933.GA8680@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124124933.GA8680@nvidia.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAxMCBTYWx0ZWRfX7SHJ0qfSa3lt
 P6mS/cWdJy2HpugCf8DAiKAVJgIVVHeXsA3Mwpjc4htwyJX5UEwLBW94HLW0BTfv3wr9IDIJMn3
 qddbLjvk1a5bxzKuEqIcK18RJCLSufbiWvJxlM2+sysdxpFLsLiyBb9+Mp2pOckznHBdCVS2Epp
 3a/KTsx73VCf3hlKxHbbRfiZ/ZP9gOzqEukvZRcWnCoOHAqLhJrtO+VWLYV4AzoLOpnhOHU9Xh2
 qSNM3UWaHQnYiITPFNFDTvuD4Zh53U4onP5kRi+El6ENZ5j1GIW2d7+uETIk3Jy2Dk0z44RU1G4
 kBIDm8bJ8xlZC5D5yZODBupkhveunGr/GO6EWbjycjhsub7GBvpa2vrCDYFX3TfuyeQt+by40Mw
 yabUmfPA0E9ttiaV1kyEg42FVMvKXMg+eGB2J10hjUajAJlMtclYg8mnFjRin75EJIINZUGe79A
 1yiW/FNOU2wydi9F3xQ==
X-Authority-Analysis: v=2.4 cv=Voa2kO2n c=1 sm=1 tr=0 ts=6b064cb6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=DD7KCJoPEUaelk3Q9vEA:9 a=CjuIK1q_8ugA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: OZS5Tj2oiNmT-dLeTzFfGUT0rgBUWlME
X-Proofpoint-ORIG-GUID: OZS5Tj2oiNmT-dLeTzFfGUT0rgBUWlME
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAxMCBTYWx0ZWRfX9dkkAFonzRMf
 ISkeHJh+OTSiMtgJdbD7bblucWHw4UytfVjZJ98arxdTixYu2k6d2K5j/tot8WSOj0zHc3Rto1C
 bEDsL/1qurq2PukmgTGAJOrnVTpqJ+g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250010

On 26-11-24 08:49:33, Jason Gunthorpe wrote:
> On Mon, Nov 23, 2026 at 11:09:03PM -0800, Peter Chen wrote:
> > The glue driver does what upstream dwc3-imx8mp.c does in
> > dwc3_imx8mp_probe():
> > 
> > 	of_platform_populate(node, NULL, NULL, dev);
> > 	pdev = of_find_device_by_node(dwc3_np);
> > 	dwc = platform_get_drvdata(pdev);
> > 	if (!dwc) {
> > 		/* core probe deferred, e.g. its SMMU is not there yet */
> > 		ret = -EPROBE_DEFER;
> > 		goto depopulate;	/* -> platform_device_unregister() */
> > 	}
> 
> That's not how EPROBE_DEFER is supposed to be handled :(
> 
> The driver core is already setup to reprobe the child driver later
> inside of_platform_populate()
> 
> Your issue is it is quite wrong to try to synchronously reach into a
> probed driver's like this from outside. Then when it fails tearing
> down the device means you defeat the natural EPROBE_DEFER.
> 
> This should be asynchronous, then you won't have ordering problems.
> 

Agreed.

> But OK, it is clear how you get into this situation.


Thanks. The iommu core can still see a device disappear during
bus_iommu_probe(), from glue drivers like the one above or from any
other removal, so I'd still like to fix the use-after-free in the
core.

> > 
> > Yes, the list head is on the stack, but group->entry is in the
> > shared group. "Is group->entry empty" is the de-dup flag that
> > __iommu_probe_device() tests and sets under group->mutex:
> > 
> > 	if (list_empty(&group->entry))
> > 		list_add_tail(&group->entry, group_list);
> 
> A small comment might help. The lock seems necessary
> 

Will do. In v3 I will:
 - add a comment in iommu_group_list_put() explaining that
   group->entry is the de-dup flag tested and set by
   __iommu_probe_device() under group->mutex, and that
   bus_iommu_probe() may run concurrently for other IOMMU instances;
 - add the real-world scenario (a parent populates a child whose probe
   defers on the IOMMU, then depopulates it) to the commit message.

Would you have more comments?

-- 

Thanks,
Peter Chen
