Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0D336AB5A
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571064; cv=none; b=JIQ7CSJmmyKSHvH9h6xdDqhIyhpu6j7Uhu+ZLciNYuc8fDVVnb4oCjQxX6zft2thABZYqiJm0EOjMOOrr6QRWTw0BFEwwPdBIDSCxkdbhsTTHiGLsZJarPVehGGkSWmDnl3uQBeLp9gP6ncGJcxTvPycCPUWOt0ApR8Yi387Vz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571064; c=relaxed/simple;
	bh=pkW5trsUQO3O2M2WtDJOUPV0AyvMmpVoPKx5fTZEaPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF3X7mXqgRKDJbhe/65za/WzsYMx3Kbw0euzAUvH0671EWv1I/819YQw0HbECaAhmko2o22z8xksHqYlxgLdF3Hfon48Rkxxj5MdZWZRdc32CbkZ83u5iX1MTYP6uFSlpQl+RBg3qVoBTPUTnv98RqN8SycRnjjz616HBNq3FHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OYWLqoEG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JZ9Pr9IN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OYWLqoEG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JZ9Pr9IN"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBMhgH2846091
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 11:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KBcF3v6N3cNbIQQxRfkuaUX8
	wTPsyQxH9smMZXqQRa0=; b=OYWLqoEGssz/m7iECFiWlIXeP5MbL9O/UejApR1w
	xkuHm5qt2yguK+ma5PwMbB5gQn2Na0/jsaMALOqEHLLSsuO3z3bQKPBYqVeFF+Nd
	Bva8oKE0xEH6isPQLEj/qY4deya/3kjz+zfvsisWN6D9TY4zwXotyefg+fZesCDN
	eD9Xhp4fEzOdAoqcVcbtMLSeMor0SEzkjTW5dpY6jO8Z2ENGkwu7x+58A2qnFBrX
	VL2Z1gJ5DOKUkPT8L7HmedI4LTJIDTATi8cmynVdeb+jYKD4TO/r0Wo8rGY1ZNWi
	XbNcX2dFtgYYZ9nxzOCOKluw29VW7DAskIGP96Zz1lQpBw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88k7jej1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 11:31:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934979ee9f1so362071285a.2
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 04:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787571061; x=1788175861; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KBcF3v6N3cNbIQQxRfkuaUX8wTPsyQxH9smMZXqQRa0=;
        b=JZ9Pr9INr9K9tj9Ipr4uhtpF8/8Cq9YG+MwWc/wVUZVRhLc06vpZlPgO4MT6hu2cK/
         8Iv67HVLMLzdNyohvIMDUBJW2Gh57/7FomobPi2Y/Hsm2pkBYJx9tWmJA2x/RQOTxVxN
         KjWT9ogUVsbfe5bv4wNDCqYISzTPjhPGcKOK4+01eD8WiNz9p/lzeqbQolU7cqhphXos
         nqNqlX1cN0HSm9Ba2XxvBh5iGByA7TIN3Ou0Zcc/0YpLYE36GCBP504TxZ995dJ/5Pb1
         BNF3I12osN76idBdK+YONR/iDFDA6U4jjJXDagFBCzuOYC+0sPckiDoSiMSqJY5pDwH5
         Acqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571061; x=1788175861;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KBcF3v6N3cNbIQQxRfkuaUX8wTPsyQxH9smMZXqQRa0=;
        b=dHiwtqBdQuCj8IBApRM6qG6DM9xbErZU8pYi38EYg5U2tjcxgYoZ9VSdHZwka4C2A0
         WP8EcarBV5viDO0Y75bwmNc8OCEw+T13u75HMTDgpqEEEev4Q8obHpyhK6RV2Ih+C10W
         dmZbL2QtULh+/0I3/Jyby1TLIZQodPAxfQHTECcJpcXOuvu+oZZG7ZuJCLEbLdrDFTA0
         cduDWfTO/kYZDab6gg/wdZmOM/eO7t/LhofLhzS/z3AdDQDJsSxlRI2+qvfXKF5Qnixd
         1obYLQrH30hWMA9NaQMz6QyiVUtDlNJOmB9lNf0NXBunh/ORVtmkpyMnA08qHPaDCeHS
         Styg==
X-Forwarded-Encrypted: i=1; AHgh+Rpvp5kK3LW+kdpcMFp8J3yKTZZXQwUZ5VJJs06GPGMgdXc5Xe6Q0og6So+Nk8a2etBOJMlYjg==@lists.linux.dev
X-Gm-Message-State: AFuF++kYxypRZ6Drlnp0h3Vj0W3OAkp2DaQ6RGPLpRwRnfyXvQu3mmhP
	dglV5eUvPRRxZY1ePwz+0zWdQVvo5pF5a32HtJKdCqC7Z6GPOzcvRkjeupIZS8cw+J1W4ZrWlxR
	pEucqZyLHPXP/aXfB9cOOAdCs9bizBH2WzhoZAtEGjpBHmT9SdlGbzptRjg==
X-Gm-Gg: AR+sD13F597VU2LUiNs1v0DOkBPSE2P3VSxBzKmvgfi6R726i5OBWe3QDXXP8vDyhzZ
	7EhHxbZFGlpGAFYZ1U6GfzCyRC6Wj1mjGcisI0Rb5iE0x6MNtxM5/2pFh458AHF+dHrKM7sl0I7
	hFgTM+AteLlyuwwFg3V0AQGd2V3Q4CM6086uXyWaFHXoydFjNwUxfRzwKpvvIqDkZRdGYKwFcUp
	t1BTHo1eToB/uUhO6ClhkvvaVfjemKS26x1n7RtKNpV3Wd7nyIzMuYDMNEaB/4PFGkI1SVHbYxy
	49u8DcIzmwWYBs48e7q0MJWVg8DrTmTWkLFCgmpG8er4Vbd+rZNJyyu1Y2EUQuJyWjsDAwlyO1b
	NW2z1qTN/BeF96LA=
X-Received: by 2002:a05:622a:258e:b0:52d:9c11:8937 with SMTP id d75a77b69052e-52df5a07b1cmr265826441cf.26.1787571061006;
        Mon, 24 Aug 2026 04:31:01 -0700 (PDT)
X-Received: by 2002:a05:622a:258e:b0:52d:9c11:8937 with SMTP id d75a77b69052e-52df5a07b1cmr265825181cf.26.1787571060355;
        Mon, 24 Aug 2026 04:31:00 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496738e7esm1342817666b.46.2026.08.24.04.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:30:59 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:30:56 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
        p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com,
        royalnet026@gmail.com, u.kleine-koenig@baylibre.com,
        chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
        alchark@flipper.net, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 09/13] pmdomain/rockchip: cycle optional power-domain
 resets on power-on
Message-ID: <ry7vprhcjccrjyujmmpf4jgzjblhm744yborbnldvamj35h3wg@auo3ajz55com>
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
 <213e3746a36f821798d3fd3e5d832d89dcf2ddff.1787568944.git.gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <213e3746a36f821798d3fd3e5d832d89dcf2ddff.1787568944.git.gahing@gahingwoo.com>
X-Authority-Analysis: v=2.4 cv=b4iCJNGx c=1 sm=1 tr=0 ts=6a8c2b76 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=9GNsruGHAAAA:8 a=EUspDBNiAAAA:8 a=u6E1p9BJNrHIpMXxc0cA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=PEH46H7Ffwr30OY-TuGO:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfX3h1mMn64LaWV
 J4gYXd2LRdCjzMNKSSLfN+QvT8Bi5RObhNdo0xF2qyvCB6m/2NYY7dyvy3p8c/rz5rqcV6bobvX
 l/4tXrwoyN6ztUpvH9nFsV0bqmF8LEw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfX6Cf4V5csc0HZ
 V3EzyQ9DjCcrtYTDZ8wQ68FCWtzwTw4QdyC6WR+CjIUWZy6pTELju3e8YECRr3tjr5+mts1Wh+C
 P++V2RjJtCX2YoLhK2+78x68w//dKfohSdUumrHO2u//5KwSv9btdsAj+NPIuqapNasMWO6+EwE
 CxyxBKpOL1H23M+PmKim7bhIygIgIpSfBYEtHzyMj+xmHZhrpWYaFaZN9ZGYfTEIoX3PzjokA4A
 yLWNIOVBW9d4tYGMrbfHeahZ4FpQjWpYBaB6hb9tG2wvra6nAraPwzBk3vLrvm3ioLXAmYPFdLl
 nNQky2rmAXk+OSwPj0OMIvNZJsca2RnsRjMxEzheAEGQa+GA8Bh3gofBhIFGdAzGDMIi6JU4nd6
 Ynaob/BNLGeAc5xcuvyfxKP48BNL/ZV/NhN647rNFws+Stx3MFhS0c/8x/I9SR2+sle9Pmtutrx
 a4/cLSr1tGtZQQlt/Ow==
X-Proofpoint-ORIG-GUID: Eed_BVdqsGUxrOZrc9gvK_4_5ShmzRXt
X-Proofpoint-GUID: Eed_BVdqsGUxrOZrc9gvK_4_5ShmzRXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240096

On 26-08-24 23:08:58, Jiaxing Hu wrote:
> Some Rockchip domains come out of power-on with their bus interface in
> an undefined state. On the RK3576 NPU this shows up as a hang on the
> first register access after the domain is switched on, and pulsing the
> domain's resets at this point clears it.
> 
> Take the domain node's resets if it has any, and pulse them between
> releasing idle and restoring QoS. The resets are optional, so domains
> that do not list any are unaffected.
> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
