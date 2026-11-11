Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402156;
	b=nMeRFo40GEJpYnvgV2/EfKN24HqbTdvZDzjcxlZ7PBwP8B2Pkgbz9xrORoAF8pElRkjx
	 klzucWu694QxVVkJiL08ycl1Wy7/rSSBJDvNF1HIEed7mA/JC0rYmkQD8sFW4eWMgXmYX
	 0VQ/nrD06Jy98UgxNMEUBHKYx6clw5kX13ST2nIK69tx4aozOUc56H7IX+0MZLwWTmISw
	 3oVE9Q/iV66RA9sLuP3/T+G9+vGx7FnNnp3OrxC2xuUemzqZOSFKE25HODpXoaHU4z53I
	 3maMbrK1ANSXKsB74ZMwUPbGbr6o58kLuaMr1t1bX3EEUYzR22/MRNa0dYkZVZm2W2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402156;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gL7PRluqOkzpLiN/UK7bTD43fl5T1IxvJlK3ZPRyK2w=;
	b=pqHz80J8gfXYlgJ2wB90kYOEv/CQtK6dTMfp5T7kFhlipMCy7nqLPO4IbkgbGvk/fDeL
	 WViQsTlAnkUBwYhs/XIQlZcUuxo22GwnL1BJxT0vQOq6+6BJOHDigmSUPMav/Ya5rDeJE
	 6WSrUnR1mgBKyM2bMqWp1EJJuhpeEdG9OnlA29ZV4fEyfxIkKMIqBW/W8ra9HvMtmZ3zT
	 Uc7h/5bZD7lFUJbo7npyiuTz3X4ZfosNu/g1Pye9vRy5WAFGNi77tIK3mEkVpLAYNqPat
	 YN9QYc2U4xN+RvYX61+CXymwbgg7qOBP+mNl7T6u9WRNK9WZL3it5KSdkhAUu834ChA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EMYvY7ez;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IuUDYmaS;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D37606A893
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 13:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11D37606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EMYvY7ez;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IuUDYmaS
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCYujQ1806586
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 13:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gL7PRluqOkzpLiN/UK7bTD43
	fl5T1IxvJlK3ZPRyK2w=; b=EMYvY7ezmzJ0k40Xt1ZuHaDmzZ3tilOwId0a9hlK
	AQFxTU37UV7LI9UXhgIZXO+CS4P1RpIm31tkGUjuTadL6oV/3qq5WgSSD226R9jq
	qbuJpilJYMz5hu+B4t0TpR9eAGf0kyGl6OxeDSpq33jzWKKYVKt79BbIX4u1X0qP
	cJm3uxvBWcuaQzBZtQiXE3DtrPa7XqBEy1P3zNquohvHnQRdxZEtl8aP4O8ghzH7
	uRH0iP7kni+J5wq4twsVr3vu5IRzq71lqawbB3iNG2K8r+T+a3vPWopy/oXK/jEt
	GJr5A2ke5Kkqx9r8eJKJwPyt0NYJlJ0rwoN4LJOSqulQGQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawj7hq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 13:02:35 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5e93fab204bso3162082e0c.3
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 05:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794402154; x=1795006954; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gL7PRluqOkzpLiN/UK7bTD43fl5T1IxvJlK3ZPRyK2w=;
        b=IuUDYmaSALa74nGIZ8AH51AvvdL58eqbUvFNjr6K9VeIVGsFFxjdYjIwf7xML8ToqW
         Aiq8camDSDqWSQZnT4vW1jjG8ZhGWzGMn6XV01wSNXvEu6Jt878TKsRFqE+Bb6EcjM8Q
         R0zucNjZUIOit2FAba6UJQK8pDZA+f30Iu+gGUam6MFDnr3uE+ca7EMDfvrqdL5+VeKX
         WFss6G3wRa/ktfh/nsqf6xErarDpaapxAhIBY/7P6X7iuTsGsQdwRGdpwBCFpBhJ4cvP
         eRCj6Cee7Vqt9MD66UMNSXJqsU7JQ0u7YL+iSvdWxfWAi8jZq2g9V9Zl9WxvOq+QoGvq
         bE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402154; x=1795006954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gL7PRluqOkzpLiN/UK7bTD43fl5T1IxvJlK3ZPRyK2w=;
        b=OIx+dLJnOdBUZTG4yYy9YCi4mKYM2xFH2ZuCcjKR4zJaA6GS4Czhbyj3biF4PtoRcp
         PjGkTc71GgnZ3CVk1497F/WEU5dOk+R/nb8NTg/oYUcephe8Uh7Se6VGZmQE3eyJd6zo
         EVew+hHYz2y/eMJ1CSut1ZPe28v408gIbo84mdChOGXjEXQ84vxtf8YShx2yVp+09k2s
         zi6yYzaIQz6xndkfdWoHj7qC+pkRZNI3BQjYLc29uNNlowVCWYiRHfwXOl6iDoLHAopP
         rFEo+Rx4iusQxsCUIyvvYWoEzdztbWNdYHYGTvYcE8lUYMnQUlrbQwrbQQl0lyDu89Nm
         Nbyw==
X-Forwarded-Encrypted: i=1; AL+hErHhh56mf8DJrzZc5SpIQ/4L48bb0Vv0HgGwmsGW6Y2jgIxWR1Lm8+LSa8GWl2zLYMZsHPjFqw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+el2/PGdt65ZzaXHfeH/F/nQ/hjg5yqpybU01NzOGvPJw3MjPJ
	bZygCFtiwAeJi+jAKZ+mNzi6QVNeTCINooeHwO9CLS0XufwP26i/LAJYq4ch8snC6ykPk/G4XXR
	KhMyaC77sEbMOxE1msYtTi+FvdHkSn4m6dJenLFUs9Vl4r88roOrMePOndQ==
X-Gm-Gg: AYBFou3UQCov3C7Bh8g6eANeG3N/YturmbDB514TI6gGJLBEaTRvRN9AwtxxVrNpZfy
	FtRndb1tYDbHaj39BILiXhpTRZI8gSrudP2+/6IK/Xlta9ZE8Z16KGtXBgGICIGbyYNAmCPzGC+
	nDz7dCOpbujqsN35a3W4pM/wigCM6EDxdKU+CXIf3xLJ/4iitf8Up2hj8Mn1H9vTTsEcsLl1yYF
	E9Bsc37MUskNGWKyuBaLErhIvdHE9r7mEQ1yRVKdK2WijyoWdKKUcOVhPkmNgQpnTO4yVW65yAM
	UEpsj7OY2NJxXKc3hmEplJhNi55iXtkLaxFDs9uLTs2JU5PjaU5iwRJ8eqzjGY8D7ouvis3hEgQ
	Zixavyrkw2OyLtfHk8IL0yr9O/uOuqM8jkVcxXC24/HDtFFzgIWvM5RuUewUnDBEJYOblnnNY4T
	w3mrSoys1+Qtq5fM9p8O5DsfJpUZv7CJ/RyE/hTj0lx+N8GBio88tKU/dyLxzU6w==
X-Received: by 2002:a05:6122:e248:b0:5ec:c180:e1a1 with SMTP id 71dfb90a1353d-5ee1c292c8bmr762375e0c.2.1794402153785;
        Wed, 11 Nov 2026 05:02:33 -0800 (PST)
X-Received: by 2002:a05:6122:e248:b0:5ec:c180:e1a1 with SMTP id 71dfb90a1353d-5ee1c292c8bmr762282e0c.2.1794402153278;
        Wed, 11 Nov 2026 05:02:33 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157baba35sm933313e87.46.2026.11.11.05.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:02:32 -0800 (PST)
Date: Wed, 11 Nov 2026 15:02:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v7 2/5] iommu: Use resource_size_t for reserved region
 length
Message-ID: <hn7dczsvgtq6siyikoaf6y5stlacmdyq53eg4mhyonugjhujlp@7k4cxflzuu56>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-2-5c0f72083e52@oss.qualcomm.com>
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
In-Reply-To: <20261106-add_iommu_ranges-v7-2-5c0f72083e52@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX+/P3/BJje9BP
 dWF5viUJjDk8R+37SqP0Rz4qrvOm3u+eIxDAQlQJzrn06mopwHfkcdDER0G6+juBi8XU+dDjWrG
 CIRLp0jPl+Btp0eY0xD+Nc/pK5AgELU=
X-Proofpoint-ORIG-GUID: Le6aLm_QxWnQO1fKLDaEg3lp2zi6aCcL
X-Proofpoint-GUID: Le6aLm_QxWnQO1fKLDaEg3lp2zi6aCcL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX+Cuo9iJq8Rfu
 4xYl40TpLo3teO/qXrDmg2urN3CT/QP9GwdCqzi+s22xB+f00NSLE83qQc1v+YXmXPvAzYeNOlG
 VU2BKa5aXr1WMu4p4I9WEuaBaKsT6vLBq1yhw6jfXhKoIwmW1DY4lR0gsJkKcfApmZd9vz+V//G
 vCa30iEqAMinwIV/M4+4jGqxjihtQI92TdVkvIqr4VKsorZC25hLZTb7q5a64mCTIN7I0xSNUjd
 /JzXB5287YvZ/J43tI9zWzSMNeRhLWcflmoZmkUCURJ0dGDdfhPt1K/VXvLGukVeWNI6yMksYr4
 cgqdYUXdMszm2PUdwUbYDGe9u1EvtTVHPPaqIgKrKW/lJ3WPxoD/4Z4p3jUNVwPjWwuzPAk74MQ
 8QdsWWCFiOJbKO/8z1dzCGqRGqHm2D3ayHhMajgUoW18gGPXujtR++AhvmCYxzuQjzq5FbnAtLq
 LaZY6mglJ+GsU/BFyPw==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af4676b cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=EE9pRYFAw_fItPXnlVYA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110051

On Fri, Nov 06, 2026 at 10:44:25PM +0530, Vikash Garodia wrote:
> On 32-bit systems with LPAE, physical addresses are 64-bit. A reserved
> region can be larger than 4GiB, but its length is stored as size_t,
> which is only 32-bit there. The length gets truncated.
> Use resource_size_t for the length so it matches the width of
> phys_addr_t and holds the full size of the region.
> 
> Fixes: 2b20cbba3390 ("iommu: iommu_alloc_resv_region")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/d223ee9f-b262-408a-a201-8b16d310bbe0@oss.qualcomm.com
> Cc: stable@vger.kernel.org
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/amd/iommu.c       | 2 +-
>  drivers/iommu/intel/iommu.c     | 2 +-
>  drivers/iommu/iommu.c           | 2 +-
>  drivers/iommu/of_iommu.c        | 4 ++--
>  drivers/iommu/virtio-iommu.c    | 2 +-
>  drivers/of/address.c            | 2 +-
>  drivers/vfio/vfio_iommu_type1.c | 2 +-
>  include/linux/iommu.h           | 4 ++--
>  include/linux/of_address.h      | 2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)
> 

Thanks!


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
