Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0415B448BA6
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905631; cv=pass; b=S0sPfyn3KvvylaCR0eOKVB4nNCmLMG1yEyYn3m7FffaMCIHbizJOJOIkrTin/ltUs8Fm4PYb+K1tw0xQoGoVYDIO/VUCqHO0nPPYWPBlmbP+7iYGMeZ39BztIF3Zi6RE91V7kwgAXkhPw/EnHn8Zd09npniPT7wL2sdtksXDB0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905631; c=relaxed/simple;
	bh=TqF3wLHIA1jAdZt0Tltgjjcw3xRF7uJIwJwkCK9UGR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgmegDkLJ2XKuIffQu3Rr2G9gbwTy2sl0mJPDHgKu+jaymLl3weu24iEkWebxcmj06VS8AjR59iP8jcbh09St5a5KNzWDVsPvV3/UGLRDoCCzdusGsfDft2sxSwoTp4vJD/r1jczMLyyM8Jd6hZVpjysHHJ0F3uE/cdPzMHYXds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CMNYH8YK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DMFf3aBJ; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CMNYH8YK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DMFf3aBJ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODb8g33344393
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=; b=CMNYH8YKsP0vLnKa
	kg5kejSOcOGDDykg6w4NaAMhIZjMwg5Hvpg2qVVAeGFA6SXIkFXHAI/V9jYZZTSy
	RttEgtp4bwm6aE9p1KGLNE0/MB+O/oivlVfzYqqXeDZ/TYz39Fv1fPEUWjQMmKmB
	ZOhZL4fM89UgzYGiONz5xZQQ8LEp9cpVqsU7E9WNOiG8/iFseatouKgfxZnlVqh6
	rWFhOjCyVDJkJyyzui4Pk9uGykx+T9GFLHJOTV+t4bciz5za3v7JZndxoHiqDk4w
	c6pEZ4xZYfHEQPLIJ2zTQeesRUAuDTSkH8JP6vyj4qfAeEMOO27lPxff5lNMPRVs
	QuKvrQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cf0huy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:07:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e632390d2so75676885a.3
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784905624; cv=none;
        d=google.com; s=arc-20260327;
        b=oapJ+mbsbCoBcN4gibn6B6Z0raT1pLodRVkQ+kVVmRONGW+bo9MicyewrplGs9JUUI
         jbCTvpBrWkbouo2m7CL/sbAdq07udIhE96xwZC3ga64beggANCnfKJN74toMegS75b8Q
         pGfz3mAYBjgb78CgQpVr7LS4gzYh1lpn++hOhs+IeMIX1xssPSbrij8Uw3TIk9HM6bWo
         czzq4JaqYoJQR/fDD84kpQj52RvoJQxkdODn4Ell8BeELK1szwABW0BMr+K3fca4h5qm
         jxQYEhjtexwhAb8nmn8qO2ESgkq1fWY0+NT9yVFpf57R/Oz8FkjIuwjCDOBOMIdNsGmD
         2LhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=;
        fh=7R5zE8T8M0k5Yip3bt4/WkwRvwdTesQ3T3LHktC9yZk=;
        b=dX7R8EQo9OafOuv0VzBdvYdl5G8EY/tvRGMSiC09eeiixp8m73Af9Gu32s+TsGl1If
         ZubHIotKNuhR6tIuguNHPdp/I/2Vtz7IpH7kOyp4zApl0w+RVn0pKKgS7+tccgMbbp+V
         +xl3Dj3BdKnWllBUImJ/p2mhLDhGtkTLdEWE9D/3dvC0L6729uSiIye/qpWiWyz3kdVx
         HtMX/Md41xHt3C2T76Sff/rqoVNFMKGAO25c/dLO4mC8JUf0iF1hsMbBNqE/HdX+tIeN
         +XMB+voRnGweXp4YPzfVD+CvfrOGdglzC6/iQkAG18vybRHa8iqhfrHC+aIKeKe7eP9k
         /Ruw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905624; x=1785510424; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=;
        b=DMFf3aBJXWZmEyyf3ZJpCzufZt2FEkCHIKwbIGE7H5jDnCfdk09N4s2P+DprWR5tqj
         Oc1pSb5MRbgVUGaSGgoxE2x3CFhqlc42CTypFDiC9IPeNrvYLKcorUyLXcvWgwZP9bzr
         ekZ8kGkkLzyZJrmblrvh/8id6VmFn33C0QKPZFGy67+u4hg1sx/RrphBW2TOO3M8q7cz
         CE42U8Y5y7RetRWXSiW3WMgqaq8QJ4Rw8yp2hElK0kqOS4IzHbR40v/fO3bWe3Wshzk5
         K31V49tVxjjKRg9l1x+6IzToM/QSLXFUeuC360eA9VAI4dyoZUCAIxni3SBO/f8EU9Qt
         3Llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905624; x=1785510424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=;
        b=f1bTWeVoMude+yR9k/bR7DhSGFI0r1R90DGBn1Kyhtebg271WaAfk3oAie+xPe2N6a
         snhTtvaDmOq3VzrPO/6aVRGJi2VYYbwJrD1pfpotU86oOSZXvI2WFnlS34jFma3+lqBH
         L7YCXzS9sOggllR9lqki/22f5HYPP1KeDj5pkP3xs0K+LHK2xw8gRY9vD8GqKur5d3i5
         ALD+ob98/WYUDXeywskmeBOgcFISc5J8cKRtgWxaf87MLVchsmATqLjZ8lueI02uTbmS
         /9CywPFofq9H88BzSW9yDu+6tffvTdkmhLnoLBdYQDwejDtRUkcJu2o+fBtKYkKnUHvQ
         7rdQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOYHBJk2ppvsN6s8R2m1xIijFSsSsxPVrREwdlgMryHkCUStrACtiNbOvP7APPfcLHWXR8hg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzU+3Yh8HGH+mJrJDCxGpKs8zAtd6dnz7gRVzkg6+RIKUIAEPqi
	Wj08C0Rt0FphCdJFbHam6GV3fWzM+iav6rtlZ2G5SoddmGGrF8M0eHc+HG6cJcc15lJQ6EXix8A
	KXkkVYNAfQKX5UqxomPBtsD3EArbtaAiJGDp1YwYCt3TzAnarUMEGgJd1MKCbdCvKm7F2Odsfxp
	fuyx7gVyytD2fv9P6LK7uJhmIwWrpgSdcx
X-Gm-Gg: AR+sD12bUjiod+4eRwGLoE6u+rpHaHOiNYOIha7TsB161a7+C0S8kh0K3xze7Ry/b76
	rDsBz5jcWGFFnXxxSpTg+iqK/H7vUJqNAc7Fwo9oYzBDj/NZWOsRbgm+i1hYV4joB7tnNc43AcR
	Pb3LrUqByXPvHA7jiCnbf7CcwfVbZEmV+vvQLuUKKnzj8bM/SI7mdRFIbfhg==
X-Received: by 2002:a05:620a:1b81:b0:92e:c118:18a9 with SMTP id af79cd13be357-93103a65117mr772233585a.92.1784905623935;
        Fri, 24 Jul 2026 08:07:03 -0700 (PDT)
X-Received: by 2002:a05:620a:1b81:b0:92e:c118:18a9 with SMTP id
 af79cd13be357-93103a65117mr772229085a.92.1784905623517; Fri, 24 Jul 2026
 08:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-5-2dee93f42c54@oss.qualcomm.com>
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-5-2dee93f42c54@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:06:51 +0200
X-Gm-Features: AUfX_mxUpEE-_djVPIMU7ZvWbbzhCFmItK3_9wrfK5-RcRFUSwGHiGhMmnFjL0c
Message-ID: <CAPx+jO9=HWwr4jGoCcWAM6fKTTrg3TphgPiNX+4yvfnyEZa_pg@mail.gmail.com>
Subject: Re: [PATCH 5/8] pmdomain: imx: use platform_device_set_fwnode()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>, brgl@kernel.org,
        driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNiBTYWx0ZWRfX0cXTrT+433Li
 yMNo68NMRnXXIebayIK5jAPigGrzdg1DIQEvsdocdeyDNTZwZI6OY6ymrXNJUPZw17qB459kQGX
 ffNzg8tTS/VFaEW2rw1Rzfde38DClfk=
X-Proofpoint-GUID: R91h0w1zzsQQLb1CPk0Vh4ImLWueINJ6
X-Proofpoint-ORIG-GUID: R91h0w1zzsQQLb1CPk0Vh4ImLWueINJ6
X-Authority-Analysis: v=2.4 cv=er/vCIpX c=1 sm=1 tr=0 ts=6a637f98 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=RwuSGLWl7VkFDbmKPUAA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNiBTYWx0ZWRfX6UpZx1d/zD9m
 PfGRp+XE9utW7TqAyzf8Y1PJjGU7IZ1V8xi8hGoigv4YiIeILJg4DZMHk4VVCuYr0cZb9I+gLe1
 azbYItpjzSaTfNz0mKaQ5IogrDqEPgR76ez7f8+VMNG6YaQFnqNMV6ubkn+52YnS2MR4e3InzJF
 Bri8gv2cglDpyCTQ/gnDUBoLljEhuQyyTdykTEzEgJkV/RgMkcv4Coib9vlTDDiswHbi3smlcXU
 C3ymOZR2tznBIlptCN3ZvtD5+rJdrKYFJHgR2LwphC5ljf+SzTIz/G2DoD4ajnr1+QGK2C0pqMe
 SDg56WdBKPZeceYX6bBXxKonraJt+Yf1I2GmHxVUXtzUVFDSzjOTznqkd2Tj3ygiRTBArs7wMKO
 ndj6k0oJjWBzIrXZ/Lbn23JBcP/Gye2jLFGuLOI5GGglp4w9BNll6iw3G9mSXr/xZ1UyIGLJcD3
 iELpFO6B5C+G1Sf7wnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240136

On Mon, Jul 20, 2026 at 11:25=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  drivers/pmdomain/imx/gpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index abca5f449a226fbae4213926e1395c413160c950..c147eaf048ba2b79a744ec870=
29420981581e48e 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -487,7 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev=
)
>                         domain->ipg_rate_mhz =3D ipg_rate_mhz;
>
>                         pd_pdev->dev.parent =3D &pdev->dev;
> -                       platform_device_set_of_node(pd_pdev, np);
> +                       platform_device_set_fwnode(pd_pdev, of_fwnode_han=
dle(np));
>
>                         ret =3D platform_device_add(pd_pdev);
>                         if (ret) {
>
> --
> 2.47.3
>
