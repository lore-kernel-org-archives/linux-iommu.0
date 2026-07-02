Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48EF480DC3
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996409; cv=none; b=jNuojo1P7zfRbS5lgjyS8g1maDM0BgswDzej0XDj07ZMUxQ8yOyZ+ofpNeiW/RtLxzlFwb9yU+1PveVz2tWa3Hll4+zjo/THL8NwLfJO6IORtQf+JxApqwa0n2dZRoj7ZO/CHSEoInd379mii3oO8wCqMx3ZPSmVwM3lbE8mBms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996409; c=relaxed/simple;
	bh=5uHYC1eO+x2S8J06bwKaEfjHFTxm+1JRWoisJ4D6TaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/dZ+xRh0s79PPsVojsTSWgAOVzZKL8dBBCGCsZ7vkAS5pg+VdH+Sc6XPQsIxeg4BRzmZCkreHQc0SkVJ6qnOTgnG/BxQX5L4bCCGziLvOBD7R733OcG5QSccc77dwqOOuBCkf82AQSl23tuSpFFP1C09BvdC619yUWEUtwFXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GCjxUW80; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DG5DUAtu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GCjxUW80";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DG5DUAtu"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662CkI7g494633
	for <iommu@lists.linux.dev>; Thu, 2 Jul 2026 12:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VxVATGBDUQiPbAXFQhZkLFDY
	sCweETLs6MuM7WPXiSU=; b=GCjxUW80PH1hTFi5yA+zkB2nlFSaBtRFmH6DXhzM
	k8R0RBoztVvXvjQJ9and6cAlKrUj+FG3Kper1/nvwF/V68UM8fld7uev/Y5m5LY8
	/jq3f5CtjR5ADB/H8PCPfyPP/ZjugQRPHiMBrQd9T7KKF7Tw72khtaC5NkbX8X4a
	QR9IQgiQ90bPgmbEAl2T7Kye09QAlGiiv5mLtRx3Ns7wYmRm5nEfmMnB5sGa+NaQ
	znhnypkPEEOpCbLivb2kY33K1VY2PpKSk4tutZYXlI0tFzs/2dp4TSr50WumxkQO
	xhspqYUjHHGJ3J1RtyBYnHQw+Ds7043dyq/S/OmLhoHpog==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n9rsw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 12:46:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e4f946461so211709685a.2
        for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 05:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782996406; x=1783601206; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxVATGBDUQiPbAXFQhZkLFDYsCweETLs6MuM7WPXiSU=;
        b=DG5DUAtu9RH/R4xlzt+2flNCmT9g2zhifr4SRy+tLhHVNp1qVd1JsgQjnmzGl6cWLD
         0G2zwaZAmssF+/BFnJLPQlF9r5TF4qTBNns3QTyQsvOCc1hw8Dksf+I5UR8ZrpqyjGgi
         JHfZq5MMaet6Pqqhwhn+hEMQhwhAfTqBS5p1v2LUCpzzYYyFuANrA20nUUleoXAS8V10
         AU5pzkjylMNluLyT5nVb+HdqKqLBggQusy3kFFdqH1NqnYPVXvE7esSebq+HOrAbldEj
         jcd51soRnjwI4EUyjzCw6ZW5CLRsEHzXrkSg99lnzGU1ekQveK0eeMUK/ar8Ujn0SLrl
         OOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782996406; x=1783601206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxVATGBDUQiPbAXFQhZkLFDYsCweETLs6MuM7WPXiSU=;
        b=lezW3ys0HJeA/ZRBm36+R4U9cCGBKzQoM8c0ueHX2nDvJLGpEaGDcgJTSvWZl8hWd/
         VJhscn5EGfCysHoHY/Gpr5BgfQ4UhgrCMcsJaHjmf9mNv/rEwmBCYd82mrv0fGiVvLhk
         BgTUd9ROnlC19Bj7g2exTl3UM3QMV4r5PjwHgU00al2kXSEJo7I7gs9BNvEkjKnZJSbf
         J8qwNQia404AXMfcUQw2y4xt6RlQhr0t9cChwVMw35xOsL5nIzUTGzN10bECQvmtw6+f
         rxI3Ee8xRaE2d10RlG4TxSvyk96XlN1r0ARVWuuaT55G5KPt9erNAk6wN6K+z8XWWBUK
         nGVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UnzHa4WpfeLHfcS8J51LQ0wnovwYJoKDTAjaMR0rnaY7P32dxMF27kzS2yjYr7NCmK8GViQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrXlwHEUx/0baT6eOd3cqAetHsCo0gs68Fzcbxks8XH0ds0KPr
	vZIbLYUoRCShqBWluF1YpUR6iKAQsK/V0c/j5WiMqfSP0ht+RJpWGXrZqRro9H+KPKzSejkSMZq
	VeGlJp+VlqRncdN2aVJOfL8W/UsAF/+5+82wsqTwKRAZN2nlm8MWM71odGA==
X-Gm-Gg: AfdE7cki2cpSdZjFZU+6lz9/U28sam5wIKsReO33DL8dJhjGclxAbBK8VMw1CXAqd4Q
	zgyWhOWOs/Jywe4cXAe4jnMXbxlQSZ5zK7qxsFycUsSAg/L1uV3OKYsGIAiEPnKbfLlVY34tHzm
	xhyA/MW2DkCckDl3c+kJCKzZ4Xisl8lCctgSmUzOdwNQCAdJ0ObCAO81IHhYZaj7vmhC7MZKXoG
	zOb80BuDQArVn8re26gPSEEYeRphcK5VLwzogeRD0tMMISULw/TK7S11N4JC/Pd9F8tsjB5yXiS
	xv1vi+7BRoLCNCL+5Ef2Ql8vCGvDVvgOc4Pw40KJyu623cRAJBsKNI6qFCUA3uWVClj5njDj2vQ
	KJextvCYizRvK/czlgLYZRrpAKzfugtkgxssuOlahIXF3VbtyvQPxz8FuQQW5+AicYz0EfUGr5k
	7TFqE7tcpA0jTtxcNP5LdTHlIs
X-Received: by 2002:a05:620a:a18f:20b0:92e:7ba3:73e2 with SMTP id af79cd13be357-92e7ba37697mr502998685a.74.1782996406282;
        Thu, 02 Jul 2026 05:46:46 -0700 (PDT)
X-Received: by 2002:a05:620a:a18f:20b0:92e:7ba3:73e2 with SMTP id af79cd13be357-92e7ba37697mr502996185a.74.1782996405860;
        Thu, 02 Jul 2026 05:46:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b37fc492dsm5699941fa.22.2026.07.02.05.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:46:44 -0700 (PDT)
Date: Thu, 2 Jul 2026 15:46:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vladimir Zapolskiy <vz@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] iommu/msm: Return -ENOMEM on memory allocation failure
 in probe
Message-ID: <nesu4iru5gs4wif4iip7evktqrqnwhg4e7efawcmd7gie4sif6@w4qq57i4qjsa>
References: <20260701222411.138514-1-vz@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701222411.138514-1-vz@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMyBTYWx0ZWRfX1Yz23gIVUdq+
 G/n/WIA46fEGezUzmUpS4soAfiLeHhosfw1HwpDVi+YRH+9t/MJNA+XQD2298iwV/pnf7Ln/83i
 eVxsIUkUK6cuXMMw967pmWauH++yYaIBj9D9pCI8nCQIhJtMjXlppADFGGXwd0TGyIubjg6xede
 LypfkBsNlFkjW+WgzVIgojx7wK2VI7dT++0WqmlsapvQu0lEQnfnnNNK0E5vFNJ666XLIdgm9Eh
 qTn9IQoBj0JlzurZdYB2Pk8L+yd4sSsCfcUIK21vENMuok2HvD+/ZDQ/Bv0w0mTEo5q0NkX9p2J
 gwj+2UXukpFncbfyMPcgyjh4/J0c4iwe9u6IrIuhsJzKZAzWVUYXXGVYENdYIV1HzMYZS3iS5wA
 x/VfHQRgTj8+Dlf1Hs/wi+yYrjbsuBaG9Z0dIaZOaazBAUDT635pcgfCut3daudesTrKs1IlrO3
 qt8N2PtSH2TQTtEYUOA==
X-Proofpoint-ORIG-GUID: yXvFPq2GNFmn-tfuyvzpNs3xi0KIqxMU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMyBTYWx0ZWRfX1xs2PlUn5cqm
 XuBndPLgShv1EhUDw0hgpL5mLjh0gumh/BJh5AIxapqhDf2m1bqdVh7dcE4IWnaQCUyHoVC5PUD
 WBdjhapJxA0J5w6IUxZoc5TWlnuN/u0=
X-Proofpoint-GUID: yXvFPq2GNFmn-tfuyvzpNs3xi0KIqxMU
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a465db7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=RiI-g2rLsoY8Z6saGawA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020133

On Thu, Jul 02, 2026 at 01:24:11AM +0300, Vladimir Zapolskiy wrote:
> If dynamic memory allocation in driver's probe function execution fails,
> it should be reported to the driver's framework with -ENOMEM error code.
> 
> Fixes: 109bd48ea2e1 ("iommu/msm: Add DT adaptation")
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> ---
>  drivers/iommu/msm_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
