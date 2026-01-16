Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139C02DCBFC
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550575; cv=none; b=gB+CJG8OU3iu8m70vNFgsV+L95Nd8NyIjZENuGG2IDOeticdDt/ox+TATAwjM8ypZZ6zWOSygFsc9GpTbEBRu3xYBnKaI0tfsO2LUjcTTaU9+bmQLTFlh7ymzVPdu3SLlYJvYGrvixIeDLsI7yI1ve3ny1OvVN+cGaBYn2vOBQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550575; c=relaxed/simple;
	bh=ne2ZFD5HGicCkc7p+7LOEcg1ZVUId2Jv/p4donXEmZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUB99Bj3Iy6VRiEhHohxW7JuiED6za//6+ecbiGIlSScGLFOXnF58fKQOiFTNB3hmpiHGc36wr8RifbUGWX/HqOVkgbih09VfU8T2/4CbUA41liamVwzEWxLJZ16SnZfa6oUH62QK917PKsUoRsRPmQz79j5VpyRDkYF10nc/Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hx4z5+Qv; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hx4z5+Qv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768550558; x=1769155358; i=markus.elfring@web.de;
	bh=kGg9wrvE7Yh6khdfRYmMfQMtLdtPPTBz6zVebGaiuYQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hx4z5+QvzDcK/RGS95gNKoker9Dp1m4DwUolb99mZMyDyTl+ceawQd0MXNg/8KO6
	 OP/ZZnwFdl1blmC/LiHbFtm1VKKyRNFBNQOMCNmYMGGtQY3ilVQXcegGFpxjJ1Fch
	 ymceS3x358aaofwLWghnY8R/Cu19DatBOrRV4Zcd1Bqak706UIPQAVcEAq6qBws4+
	 q2AtkxAWapw2ZBu6bHJcwcr3ydXiOIarnVkmjbcVErncy9KW2cvP2J5aSH5N2ru/G
	 11lyQgq6FjezhlpxeQQJRLLGja/4nMwQBm8KQiQcQBeuerkvYlzCYYJmhWwyEkdKK
	 y7FFNf5nl3sLTmLVqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.218]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3Eut-1vfIPL2Xhl-00DwH0; Fri, 16
 Jan 2026 09:02:38 +0100
Message-ID: <2067dfae-5399-434e-afc3-ca6a5816f78f@web.de>
Date: Fri, 16 Jan 2026 09:02:30 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iommu: simplify list initialization across the iommu
 subsystem
To: Can Peng <pengcan@kylinos.cn>, iommu@lists.linux.dev,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20260116065554.830579-1-pengcan@kylinos.cn>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260116065554.830579-1-pengcan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W1XWhh0DN3DeVjXBWJ+DXLKoInXKwxIozuMn+yZoNWpQX55PZIB
 lfLXvflw8arY7lG4TPV5eWBdXe9i5SPnRN426RXbUUYyjTLEWK0D3NPqVDO/F5TRlbd1W8X
 S64LV9l+aBmuov4HQSVxqY+GLFS05kZTiN7BKr52IoKqJZ5LytamHtYtj8/Lttgdn+/UZqV
 HXZVvyRjibO7RLQSOSdsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UevudTey0aw=;eNJcudXxiM2bYoRp5CGN8ohg70/
 5BGYzqOf7cFvIwSCc6UMm2Va0mczhVzMjAtiYt5xKZD4MueCFRKyvk4Jw8+Ns+onaYDhEztoZ
 Q4W+kyt5OBvumZHTWtaKqNGsMJavhGRxPoIiQwq2PiX9UqbLYkOiUewNuDL9/oem097RdfZ6f
 rjhO/nWtbboQ2/C5BXNQQJXqGXEeuBYRYfzvx53sW0429N1emoLHYxLcXIC2+MXAhwuKaRpyO
 X0dHqR75IXkWUfPtsdROXB6QFCXog6XcNjSbBDpqwiPD+5VgL5/EYrv/tM4K2EYvu4lmUcqjO
 jqv1Kn4R+4GRDwhDQFtP2mYOLvny0YtKv5R+K7SsApvgbd3+3hgiPRkTi6sMD02FyVQNqVo8D
 O0sMrO1MqN4UBheO+SYZdho7JJNQxCJd7ub1+SrpPqEvAruL4ZDXjK6OR5yZef+Lt/fViXMfE
 MFv2M8Hz+/gjUIsQEJWiqv/8kN2lrMPX2kOc2djE5AaDxzUsMoFXSa+JZE5ORKdEjVlMgkWur
 uFlg4px2sDRh5KMSyFZULuFRJR8WTS5gOUh32Id/saZ8JkJE/51DrhEiEnnCsFwzZDcsYNvnn
 cxWXH7UHXtkckU6r0BmhE+UAO70aYtTjlOginsXkX6ypw9TKceLK5rmLwHmfQ8QJskeiqxui5
 JBBpZQUop+iZAkPwFFYUc+dvWWYZfcxxLmB49bf5t0e17PfukHD/q7kmBQ6O4W8q8+2nDqRzE
 LrZHY7e2Fin/DfpEBw+ACwyDk2XyWXFywlyy4edxfoozrrgnYj2QX67gzIsmVKH46M5JWaC9u
 vkCk01NFd27V2zlP735Pxm3+piTXSJQZJE+0EJg/eEoGy2ANWyeYwxmSPa4471ocfwk+0I4++
 s2WhpPBSfPBMk92NmGOZ5+n8iEFcsvWkG6n172/YXU030nICY/1vGuCC80Wh+w18Nn/ApSgof
 2spw1x1+DOHytvC1yrILOu0pciwtJyXJCiJdnuK4Gx+ejdgwbf8aRGmiq9+8Fwon3pHG7kmz0
 nzW7Y7ahYnb2ZPQ0Vbt14QU5baSuV04+sPaVPwptw+IeljS/m6tsJo3Ge/zFC0i4TgQdxgCfh
 UYCkvNmYneADKntvzOQljIOz6pRN9ejq3UPibdt1b6SEqAAGZ/XkTllbFx+YwXInIISWbXATp
 Fh0hwiF4JI6R5u1tPggW1tF50QyC1LzdzWysGteYjDxssicCfAjzNBYQH4NLcSDzRmch03/v5
 7tX5RVsBVaX9DaoyPCHA7lzihEUg7aSMzAi7KqZxSB9sOk9v401kU32Dap5Agjay78Gl86ubn
 vIzHpel88qz3oDREO00h8umkhvZPROf2KIT5HUrV4GClnw/97iKOkMX8B1RketQIYfGAv6Yiy
 tOymxu8Ryh73reNmAWNh2u4PbczVBHdnAxtx5TnTgt2KdkzpQHGvPKs1ixS12J/MBYK7nQMro
 DcSDonrp+ZYDAJXz9UhcuE3g6xBGAqGZd2OmXAIwmSdJAmYSdydticfEbaHd0Fudc9SMQUoO4
 CmkcTmKcrldT8n0+uN+qHRsiqMeF+oKDuDEhtHXRvIbyY8tm1kwQQJVVedalSe4pVJ9zlEwtX
 4Y4J/n3kvcUAMgXRJ2qTF/X2lxE7/qpFV446KVT/y2Lc3RkoF70iR2h+O/XNnPLUnjCjy1ess
 3RA7OL0s4XSy9i33+1mImsgAqtn0ZMmxzOMXMWypgc3me9gw2TAJaFI8X3n8NCeRcoITvb3Re
 mowhD1w/7dk/KQ6akata3rp7PB1pKVvpVhHKY1m27bfjfFa9A/Dq39k0vL/wyuej2umaE5rEm
 9uGbsvRKwyq0qJcOTRjLPuLQcqvvlgAFuc6rNyzx2faeBYpUubiOxouoFS7K3N3RIty2+ykI5
 v2yNecfxAtFAGlZp9GNmorwCJLAmjPmnoOWH1hsHlf6Syl5woNYUUIZ0rhN9wSOceZzsfiDWw
 FveK7pMaC9ak+a1XvwgakfHqSJLVN1mSALLxjSPvNUT7/E6jJSuz9b6m7mu4rIMfQJAr+V+sz
 jGOhEDFQY7FZlxufHW75Izb4M1PqlssdnEzUD6SjHNdy0o165FkfEHZYOUU+XIOY3zZl4Paok
 Uegldj0YWxo4m1o8T1kohxapTKHJbIxobAbgl1WYi0Bh29Gpog6VHaXwAp0xU824sN0wrZd4n
 FNd9jISbI4LW1qDE1Sq9P/6Oy4z4xaisYDIOtr0OE1e1rp/Fkhx2oKPZoZBv9o04iKWJacz63
 48+FnOB/WVmaRRHWgVFxtNEsuKmjg5Nv89qJP0lMZmi7vxpReYjIm/sVmaaelY3HRMurZzmxW
 2r7W3RHzm9FV5NhHhBmuvW+HMeCrZSkpqmyKujlYDdceVugFenyh7toiDtL1aq+mP9bvvcq4J
 3LFn6lMjtasdiVA8015WBYorqFR5l9TXwE8xU2GMTF8PWEi46r8HqO/FhGayo0XTEYddUtsYe
 D0XIkPvVyyLOKQWcAIi7fm0U9NSdkq9fnMHe96XqDiNRfcItUaQ0T/nBJYLkRGL4XTGn9e1Ia
 xUDBL5p5NERzCQxumpNhVt9cghAqTCwvbdwi/JOljpu+NZLDybXePSbCVKrQibBvr99epS+4z
 tAy7CEP2mBig/fFRF/x30XZErFK2eoouxYV2EfBtuOlcBKsEOzp3dfNxRSPNa7vnDCyQ+AQb8
 cHSis7Uv3vrOvvwPPDxYiYzVnXT1pkwRdv25bZ0VdRkVLhGAUlfSWaas++zoaowKKteWwGXl+
 LkXAhaCwTQGh4eWHAmUA5DLgZerOBipAixZrSORx5skCUM4Ru4UVuktrOYF3ZJZNZHo0CUM/E
 Q8KBr5LP9PH5ngvG5lvNo93/jTlxOz2XqOeZiw4SM5sz2xP+pKAsbzdg6aoW4SwNCwfxyswz6
 6XIXDmVoJcj+B4ji8HPRDQ0QNuRRS595rYqpNGE4IAiJYBlX78ja27hXzS14uTSNgvlBGIbOK
 +buA30wBHswSaQcx7cIW/yeN0Ph6BtTv2FIrx9w7q7kV9dFkTKDQmDN4vgUo2JezJJPXM3vJ1
 tu/n/Ubf7wSw0r8AdEMMMf/5gXtRgVOalJ74nfDkJI96h7PqAwfOBmk6032Wm5H2od+e1Eg/Z
 P+UbMFPyfJIK90p+dn5PZBtROuuTK4YaR+m+JSzHLuNTVihcx/Y0F+6JKRASvGG5VSVrrWImo
 BJ9skO/jEa77cA/klUZFFWER1Qkzwtxyexk2en14Hjf1+X3ZIYO2kZji4poZxSjUmKDK90cBE
 AE3K0Gd2AX8Y9LrczsX6xpVgdmxjRgxc0Oa6Q535mx8jQeP556YXYQ9WWeTzkiWBp5GLAbK31
 hu3uy8becHsXURqKquZI8xLxhwrrNCJ/4CFkqyPbBz9W14UlcFdHcGrXQpdltQtTfbFoGFZ1r
 lDGCHjf04ZeWiHTCQyGaOXqAThBMCjW0cOWwBgZQ7j7C0ynK0sChNBXkvcgbb40uAL4nN2/OM
 ED6i5K5fT1HNjeLKnKvPTbFOOv1u+g4gx2FRCkoDtqegOgsIW3mPYN4WRs76a1vi5KeyV29qQ
 usSv77NoxmkVbswWXrZHudB+toMyYlldwirhvlch97X8AkrD4R/b/k5uvelmjpN4VEyLSqmSv
 swSU4hPUZCgveXX8p7ufGailvyYSM6IKU5g8YykZrpt/e2KNn6HWUslczC5933YoyR3YqQFNV
 uLQVwW8e9wJH56nq+HZSoG4SW52sI0oL40yYBfUOi3+y23ahl5xWuN8hQVhIKqxoqyBunVLMf
 udJdpU8wTDngFBDedmx0hxu4FifTDLB/RQJf/pL5PfzBT7thxFwf5oLGeN6qkDu9sykbcQWQw
 NkcBZ9M0l+SWbZDVfIFjYIjsYGCAmDi1SiOO/RLPn58QTuHWNVnDv2YxULHwF+4FjJa0vYsqY
 8v4AnuBq6kkSeEfmhaOlrmrQzkNJHljnM8i8lwLoiBGEINoAxN0/G+bGpge0nvtAe4ymObC/h
 a4WwGR1EfkDFrkKt+4h33nfl3x7TvM3/gnac5vIuyv61Dff1a+Vb+pI3xcJKTFUMc1QNR0+I9
 Dklp9ydWI/ieuoh2GTxGjluIM9JYnWaSuKFyR9G1iCP7GNJMl4Gj+MiccCdt2PzsAP+y1tH35
 GzRzd1++H9WGca+7cY8iRiQka5QGY7WBxuaSksSRR/0yRGol5lQLFbWXR9dC8ILxSTpWbXDEn
 XL1QRhiMNspG0TDUmrZBuvpDGGnj5xApPMFeULJ3V0uBsRigie6UJsUNrj8MiCp6gSOoBBuZF
 wB6bpoCbL7MpJzlcAkMMHFbGufiuRTfi1ITmGhfuA15eEag+empiRq9zlWAIzda3Yv1R4MWeh
 GlVB57D0KnzOrHZ24wDoFv3DmWtX+Xr9XM1Mfwnv/8sol1cwZM6wky95cpEI+DTBfFMA6eOWw
 spB2XrMl97685I4bheZOAwgRlfDRemP3QtAkBrLk7lFN5cfquOXlyvsAYJ+SNiHRHj4HChFO7
 yYGYn5Eb2tCnfL/PpUVYCfwdscm3z3hdcxm+B5P2LbK0BUdlnmq+2vWw7UxY5fnW3qNM5jk6B
 aWKMScYbvBiCnpd7InxjU93aq9MuTlWvBB46bVpAUYCKZB3v++63imFgVfvE8Xdv/kG2Bboty
 ftI3a0pPQqtlFbBNsh68voT3rkGcJZx2ZaizaZHqSc/yoqcEUz7VlxEA/8zCLra+oCj/67LAK
 3xaFEbLH2EiDQJTikqcnZ4G70JbkaZznk7UVflu5tOfnMtefX78QgEHaAlgZ4Witrbm3e/pBb
 YaOjpMBgt6cvPVeAYbPgkrltrFAEQgx1QcQSOfo8JemADvlqe6yrCJQMXzB0uGvjdqwf0k8K5
 odm+8MONVWOI0XuZhd09mxqdUShw4xOArF3pHUV3pgAzLP+aWdvzz6/xjZS/WOyH2bcrRUs7x
 857/MrsM9Ld/PeBCt0OstjuzRrkyjZkf/Z+A6Rn0K4zIus2byi5cx1lJ/3bFCQ3cBxoMmAlj0
 +SDZpNjSrSfJgHoEEXHUABMtlMU6HLqfc+e3mD7dD6Y/n2RQ5laZMvxIEbIY0cF0c6uV8oyUj
 7iz8nnXEyivgy1rh6O6q7GWLVnVkAt9cYpwWdowU9mv1gyOQ3EhJj+EH12crMKPruKb7uji6f
 1Mj2bSMYf3b5fYnbu1ruzjubDuxX2/UKRuaNtlG8rosvHIH54B7RIlErQ1/A==

> Replace separate list head declarations and INIT_LIST_HEAD() calls with
> the combined LIST_HEAD() macro throughout the iommu directory.
> Using LIST_HEAD() merges declaration and initialization into a single
> statement, improving code readability and reducing boilerplate without
> altering any functionality.
=E2=80=A6
> Markus Elfring suggested using a more concise summary and
> recommended the use of Coccinelle for this kind of transformation.

Some development tools can help to achieve desirable changes in more conve=
nient ways
and that possible adjustments would become more complete eventually.


=E2=80=A6
> +++ b/drivers/iommu/iommu.c
> @@ -932,7 +932,7 @@ int iommu_get_group_resv_regions(struct iommu_group =
*group,
> =20
>  	mutex_lock(&group->mutex);
>  	for_each_group_device(group, device) {
> -		struct list_head dev_resv_regions;
> +		LIST_HEAD(dev_resv_regions);
> =20
>  		/*
>  		 * Non-API groups still expose reserved_regions in sysfs,
> @@ -941,7 +941,6 @@ int iommu_get_group_resv_regions(struct iommu_group =
*group,
>  		if (!dev_has_iommu(device->dev))
>  			break;
> =20
> -		INIT_LIST_HEAD(&dev_resv_regions);
>  		iommu_get_resv_regions(device->dev, &dev_resv_regions);
>  		ret =3D iommu_insert_device_resv_regions(&dev_resv_regions, head);
>  		iommu_put_resv_regions(device->dev, &dev_resv_regions);
=E2=80=A6
> +++ b/drivers/iommu/iommufd/eventq.c
> @@ -21,12 +21,11 @@ void iommufd_auto_response_faults(struct iommufd_hw_=
pagetable *hwpt,
>  {
>  	struct iommufd_fault *fault =3D hwpt->fault;
>  	struct iopf_group *group, *next;
> -	struct list_head free_list;
> +	LIST_HEAD(free_list);
>  	unsigned long index;
> =20
>  	if (!fault || !handle)
>  		return;
> -	INIT_LIST_HEAD(&free_list);
> =20
>  	mutex_lock(&fault->mutex);
=E2=80=A6

Does anything hinder to apply LIST_HEAD() calls at other source code posit=
ions?

May variable scopes be reduced for more use cases?

Regards,
Markus
