Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079580;
	b=TlFKV9U+D/rzwApSGU1vRRkpwNkdqESETcvMURoIHR/+RS0eGnUOs8HSQNvMrVQDkm32
	 il5IkpgNhrterJGOuZ2dELg8EbK3G6r6azoYg9owbbw8gfl4zTthaP0u5kde94H83feqE
	 RnGjO9ei7uSqc1FQ/DGIE0d0AEpT3/Qv40frDLWGkWEC9LwHj2NzfUZ8c2nIAzcNwEqWJ
	 n9czV0t3eeM8TBbj4emC/6xbHcAMfeA0RBeV167EIXpht9rABkz1q2EpGG8yv5jsbA23L
	 8TO0AE3TGFvIBS5D/5abB/Nm4FTrJxkIBdMVWdjR/0PRdppX0nVtMflU0TRrA0ol//g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079580;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iIJdGWKhMzg94WxFYkaSChZ0Q2ESvRHXcSSilwjNWTY=;
	b=Ggiuv5S+cYzKylG5fdRMvmak0ISlAaNTLY1yd2XSanAZ0xA00tOhSgq9rFV9Px2RWqYI
	 gyLF/BkFpPl0PaDcY9Kh6JgsreZ0GCxXnZAU/QdmtA3CzPxwl3JYotb5EATtImRFQIZnX
	 O3JnwBsdcDfQwv5YG1SGO7HsCoHwl3nYneNTOEqhM8e/PfBdP7QzpfCFj99GTH+skLQIT
	 1N7zRIJYrPIoNrZ3BJJSt+T+ZFucGYbHvwxSKy0ARJo9Qp/9STWeXD0DXwmvw16gpThTB
	 J5mOh7IRa3nXlZFQSlBKc2wHcfG4XG+oJ2dwqTz1ce6pvNoNAbykiZRBc2y83RnZVPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gvNMDXwl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ojfhjssp;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC0606A320
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 05:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FCC0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gvNMDXwl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ojfhjssp
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5Z2391297003
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 05:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iIJdGWKhMzg94WxFYkaSChZ0
	Q2ESvRHXcSSilwjNWTY=; b=gvNMDXwlelP+132CMJKXIstnX2Z9sLcyo6gCiN3e
	MDGyYgFFK17/2o09242SVzOCxXoXmSgIHYXzOP4h4iM3PHSfwtU5gbUadudXibPq
	yGNhBNZpmL6d56SSuKMz0yXVGyB60oLnL2+4LfwoO38kvXinlq9P/QwhJaJtAp/b
	eGdw8CbDt3R3MjE7Wr+vWVpsbk5MCED30+VkkWmauVmQVFhAlRBEN2AhUpgxc/mW
	7aH5Bf8gitANxKE9W8fX8nY6IhG/LQ6kqXtuGH9M0QQlpP/iB6yLuV3VQ9e9ZyIx
	/rQabLBNfR++CLg0Fz0hgzJkeeY3u9J2rUL9r9hkv1w4uw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj79xu9b8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 05:39:38 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c902e0da2so703335eec.1
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 22:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793079578; x=1793684378; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iIJdGWKhMzg94WxFYkaSChZ0Q2ESvRHXcSSilwjNWTY=;
        b=OjfhjsspB146jLJwjhaG+txL2nviWKmd9BVT9OvZv/fJAO4zIC1YWFk8Yfbttnq+rJ
         jDhlgWG3RhZDKS7EYiid5o/FbRLoy1fNehWJEhD12J6PbUppx/ZYIVZ/vkYlrcrDiwhq
         e3A7JR2PH98ySV3oY/s3M27SlIAKSWI2hdnM+VQgvVv7zMxjPsjDlmSxyVE5UAAty8wx
         MZEpZiRPmu3BYGjy2ecADbiTiw0jUkcuE//LOBt+eLZQ1Znkx03BDmnjcS37+JsgRRWQ
         Got5LAZ29jFb+vQ54b89E/Aj5dUI7DX1T5LE4v4WUjj6ZDroz97GZzh0WteJGPZlnXt/
         GraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793079578; x=1793684378;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iIJdGWKhMzg94WxFYkaSChZ0Q2ESvRHXcSSilwjNWTY=;
        b=IEdwQPQbuYqLyN6ClF3r83gDxrAURYJvS9oD8CSxbe9d5KxV2VFUvYuJE9ZixpRXy9
         QTIZK4i2lJAq5gakHq0wuW43IYu+gh43dfwZEGIw6l+tyxorRC2mvJaMD/JMmtLA5LSN
         FgZP+2CJsVHyPraGR4Vo1sypWjBQLDPBxXmgfVC/FmcSckijcm2lE4XuXHuMWKUK5oFa
         YDZZVHsFVAcYb7K6GXwyL1uyWfh5Gdk3rTlpvEm9lUtqwgX3m5nwopORmS+G9c+UUOJE
         lK793P5k1tF0cgKgpMjcAkRWayFKdnHLSYjS++7YV9a0nQsJvfFspgfILKuRNCSDufj8
         eVmA==
X-Forwarded-Encrypted: i=1; AKwUvBz8PYwi3BVU5ulBAM1GTto+H2he0u/Efb9BlJIsS98J6JjCkmItBx/+d5/7GoV5Q/o4tYea8g==@lists.linux.dev
X-Gm-Message-State: AFq9FYJQx2pCfqNbvGUWiqa70D8bI/AFTKMWwJvp5YKCBpvjnoJdanSh
	ORWYxyTpBcaVxDO+F0PKI20xDE1D06BahjmuOqD/huzJzX8r9SwipTbBtjhOa8dKNTlL/PNK4cX
	6kM6T6pfqqQnmMMgbonskAzwfHDFnYu+y30BNYCYI0/bS9nswWko8cqX4Wg==
X-Gm-Gg: AYBFou2lqJMO23pAXCT/5UCA/Orv2+GhZ1NMKV7HmbjFa5Bk3tj5PjlAz32YGJ1QD6Z
	BMDeBIdl48gFRGjRQ7AHptYV7NaIHKUaRrPIcE1t4htORzsI2n9IYl4YvKfjoLKcgoX+dBj7Iai
	2xkjAA0w9CV6WT6RVGxwlrVoqdQsRDgclbt73VQsQdnDAhd2WlE1YdU3ud4q0fNZSB7lglzzts1
	gSGpr+60YjukTvOhR7ibkvaE2ySl4vn7YYDVYbSU+S/e9VxFAZ9VN2mSfJRlWon32Y7EhtiP53W
	tv8idcuPk3EI9yWW2OhPfjKBINR4ZdydeIwReyviuDmIjQVh3I4Jpm+bj0HD9ydUPdsI1TGUx5J
	bcEU7qAIwoJw6FwCqGWInV98d9mvnHxXBr8TZ0hUOpcOjbiCs
X-Received: by 2002:a05:7023:a8a:b0:14e:37c7:2b20 with SMTP id a92af1059eb24-1a3c5e708c3mr2542341c88.20.1793079577843;
        Mon, 26 Oct 2026 22:39:37 -0700 (PDT)
X-Received: by 2002:a05:7023:a8a:b0:14e:37c7:2b20 with SMTP id a92af1059eb24-1a3c5e708c3mr2542302c88.20.1793079577101;
        Mon, 26 Oct 2026 22:39:37 -0700 (PDT)
Received: from hu-petche-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm27366260c88.21.2026.10.26.22.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:39:36 -0700 (PDT)
Date: Mon, 26 Oct 2026 22:39:34 -0700
From: Peter Chen <peter.chen@oss.qualcomm.com>
To: joro@8bytes.org, will@kernel.org
Cc: robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        fenglin.wu@oss.qualcomm.com
Subject: Re: [PATCH 1/1] iommu: Hold group references across bus_iommu_probe()
Message-ID: <auA5Fo-m35EMgmYj@hu-petche-lv.qualcomm.com>
References: <20260929070737.3798358-1-peter.chen@oss.qualcomm.com>
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
In-Reply-To: <20260929070737.3798358-1-peter.chen@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: gZU1bTTyatvq7Jk3hijP0TXHQU7XMAIH
X-Proofpoint-GUID: gZU1bTTyatvq7Jk3hijP0TXHQU7XMAIH
X-Authority-Analysis: v=2.4 cv=FPyOVOos c=1 sm=1 tr=0 ts=6ae0391a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=UKnF6JsuxYHOT1UCHVIA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAyMiBTYWx0ZWRfX88UySwOoLyHa
 VW0H5OUNLzapCdyaw9TtwCBMMxOISdpaseu+RcQuoNOC2n4HAeoS6CVnTCjCAlBuSTY1GP4Cqrz
 YA79JI6vKyvFL3I4+zvG0SV1poFin7OSIQr1DNFxq5wkq0GFmaMWAIFPmIVkl7TsErkX3iFmwz5
 K0mcf2AiS0iLkr6YC82JOG4sziJDSVy/LVafcU99F6chyWIeZzM+co9RLUL8qwVR7GB1Kjqh2K8
 kVD5JdR/zRVZQvoB3j9yGmYwnyOCK9eY2cam1xKA0/gGsOttOe+b2QQFDy/7XKbWgtNlGNSv//G
 MOWnsaZ0hqlWfxmfdr7SUauhClVSrnnPKdHQ+hRtXWMvuQuP17Gf/xzYllPs3QcyOAUMFZTbLGe
 T91KLaM5Y1EUtzs1OsYlzQE4fxFiUpkwT/q21Q2SrU1k9eEf9O/yKtuZUWnuU9V8LdwH9coNm58
 dmHHwFqbz8sIcROIZBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAyMiBTYWx0ZWRfX1FscCWPC/VsO
 XyWF2SR1Vza0Uk6GZgCvQW2XI2CbL4t/pcJxwDZ5i5SS9pbG+ubBdfNuPazNnJaZS8IeiSwdyu5
 vql+CFVsMcDHZH3JzdNYDxhSvC6Kvs8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270022

On 26-09-29 00:07:37, Peter Chen wrote:
> bus_iommu_probe() collects the groups that are linked through
> group->entry, but the list does not hold a reference on them. Only the
> member devices do. A device of such a group may be released while the
> bus walk is still in progress, for example by a BUS_NOTIFY_REMOVED_DEVICE
> for a platform device that is depopulated concurrently. If the last
> iommu_group_put() then frees the group while it is still linked on the
> list, the second loop of bus_iommu_probe() walks and unlinks freed
> memory.
> 
> This is the "iommu_bus_notifier() being triggered during
> bus_iommu_probe()" case that commit da33e87bd2bf ("iommu: Handle yet
> another race around registration") left open. The sequence is like
> below:
> - Process 'A' creates the platform device 'T'.
> - Process 'B' (eg, arm_smmu_device_probe) walks the iommu bus, and
>   allocates new group ID 'X' for this device 'T'.
> - Process 'A' deletes the platform device 'T', and frees its iommu group.
> - Process 'B' finishes walking the iommu bus, and tries to get the iommu
>   group from the list, but that iommu group has been freed.
> 
> The kernel dump is like below:
>   list_del corruption. next->prev should be ffffff8064a984e8,
>                        but was 0000000000000000. (next=ffffff8064a9a6e8)
>   kernel BUG at lib/list_debug.c:67!
>   Call trace:
>    __list_del_entry_valid_or_report+0x148/0x14c (P)
>    iommu_device_register+0x1d8/0x268
>    arm_smmu_device_probe+0x588/0x624 [arm_smmu]
>    platform_probe+0x74/0xb8
>    ...
>    deferred_probe_work_func+0xa4/0xf4
> 
> where next points at ->entry (offset 232) of a freed kmalloc-512 object,
> the released iommu_group of the depopulated device. That was seen
> on an Android 6.18-based kernel, but the code involved is unchanged in
> mainline.
> 
> Take a group reference when a group is added to the list, and drop it
> once bus_iommu_probe() is done with the group. With the group kept
> alive, a group that has lost all of its devices in the meantime can
> simply be skipped: there is nothing left to attach a default domain to.
> 
> Also drain the list on the error paths. Returning early used to leave
> the remaining groups linked to the dead on-stack list head, so
> list_empty(&group->entry) stays false for them and a later
> bus_iommu_probe() would never queue them for default domain setup again.
> 
> Fixes: 41df6dcc0a3f ("iommu: Keep a list of allocated groups in __iommu_probe_device()")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Peter Chen <peter.chen@oss.qualcomm.com>
> ---
>  drivers/iommu/iommu.c | 41 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b486b8bbd1fc..6965b89e76bb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -682,10 +682,14 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  		/*
>  		 * With a group_list argument we defer the default_domain setup
>  		 * to the caller by providing a de-duplicated list of groups
> -		 * that need further setup.
> +		 * that need further setup. The list holds a reference on each
> +		 * group, as its devices may be released before the caller
> +		 * gets to it.
>  		 */
> -		if (list_empty(&group->entry))
> +		if (list_empty(&group->entry)) {
> +			iommu_group_ref_get(group);
>  			list_add_tail(&group->entry, group_list);
> +		}
>  	}
>  
>  	if (group->default_domain)
> @@ -1951,6 +1955,18 @@ static void iommu_group_do_probe_finalize(struct device *dev)
>  		ops->probe_finalize(dev);
>  }
>  
> +static void iommu_group_list_put(struct list_head *group_list)
> +{
> +	struct iommu_group *group, *next;
> +
> +	list_for_each_entry_safe(group, next, group_list, entry) {
> +		mutex_lock(&group->mutex);
> +		list_del_init(&group->entry);
> +		mutex_unlock(&group->mutex);
> +		iommu_group_put(group);
> +	}
> +}
> +
>  static int bus_iommu_probe(const struct bus_type *bus)
>  {
>  	struct iommu_group *group, *next;
> @@ -1959,7 +1975,7 @@ static int bus_iommu_probe(const struct bus_type *bus)
>  
>  	ret = bus_for_each_dev(bus, NULL, &group_list, probe_iommu_group);
>  	if (ret)
> -		return ret;
> +		goto err_put_groups;
>  
>  	list_for_each_entry_safe(group, next, &group_list, entry) {
>  		struct group_device *gdev;
> @@ -1969,6 +1985,16 @@ static int bus_iommu_probe(const struct bus_type *bus)
>  		/* Remove item from the list */
>  		list_del_init(&group->entry);
>  
> +		/*
> +		 * The bus notifier may have released every device of the group
> +		 * since it was added to the list; there is nothing to set up.
> +		 */
> +		if (list_empty(&group->devices)) {
> +			mutex_unlock(&group->mutex);
> +			iommu_group_put(group);
> +			continue;
> +		}
> +
>  		/*
>  		 * We go to the trouble of deferred default domain creation so
>  		 * that the cross-group default domain type and the setup of the
> @@ -1977,7 +2003,8 @@ static int bus_iommu_probe(const struct bus_type *bus)
>  		ret = iommu_setup_default_domain(group, 0);
>  		if (ret) {
>  			mutex_unlock(&group->mutex);
> -			return ret;
> +			iommu_group_put(group);
> +			goto err_put_groups;
>  		}
>  		for_each_group_device(group, gdev)
>  			iommu_setup_dma_ops(gdev->dev, group->default_domain);
> @@ -1991,9 +2018,15 @@ static int bus_iommu_probe(const struct bus_type *bus)
>  		 */
>  		for_each_group_device(group, gdev)
>  			iommu_group_do_probe_finalize(gdev->dev);
> +
> +		iommu_group_put(group);
>  	}
>  
>  	return 0;
> +
> +err_put_groups:
> +	iommu_group_list_put(&group_list);
> +	return ret;
>  }
>  
>  /**
> -- 
> 2.43.0
> 

A gentle ping.

-- 

Thanks,
Peter Chen
