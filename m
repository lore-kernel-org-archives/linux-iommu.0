Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8AF49502E
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994614; cv=pass; b=pOAJtJMy4lO3WpzSiQUBULFdHKRAC/JUpBfCEqAmSt/Elw47B2EnWL3uMQlFmkroG4GUHZ7/+pnvjbwhF9F7zCSY2eCBFK/gv/s4K2YTAT/GeRALqIpCXqoMLoOt2yVuLsIRK/lW4Awi2HYJD8PaaCITQshn+L/+yfkPykSath4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994614; c=relaxed/simple;
	bh=Ot1FxL5JjYevslt62pC/ZLUd4qxLHu56oryKSsjlHBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4eF86RHJtQQP0cLnW9aUTPFD9hU2eqC2jEk2Yo9oFSmBTOWOnqBHbzTthSuz5iyEOqEW7uy1RUFGqye2Hqhfn7P0j6gT8c6oFpbDvR7mDE1E41yh0bQvJfSYh0Duo8XGOibcY0vLSpsXLe00Pvu9it/wQ+YU99uiMtePXQShvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RjNhQMW0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XLH4tZPz; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RjNhQMW0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XLH4tZPz"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LB4pWh1130013
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 12:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YTc4eaTqTCWWXmcCsM9hd8rF0EjF2lDAr6pE9wv6n6k=; b=RjNhQMW0qXvCl9e7
	TSqSjkDCMfDvn3tLw3Cir5ZYA42nfF6E17HauGaX61Fj0ylBQweO2l6cu7Ja1ckf
	bTkYPxta1GMCaU3pKkI2VxKH3oak+zv+0Td9/U1IMNUWo9PGFgsaXdK0JbDAjy8E
	9WUe4FSN44FrQeReNOrusu4zefIi2DGS7SlM93UNUJZ92ubgeva2ZyevUEOjxHgm
	1KotCQAkWGKs8y5QQHk3iqcJBOR/BwzySMjwYrff7wXQWAIWtINpjTKMkhDJSjpT
	vrUr230c/RwSaC9P6ePBdhDIZFQVeApKVBjMFEfHcYYTAeFF6AZOdcpBgQs4XRUb
	HmK6/g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu3csgbgj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 12:43:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d94f086fedso43405025ad.1
        for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 05:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789994611; cv=none;
        d=google.com; s=arc-20260327;
        b=cFEak2g/yR7rtUClJfndrg73a3BUQDMD493jraIsCnBmCxHH/FIaboAzIOLJi2lsI9
         ozXoLymi3byv3Cs4uMGGWLdTHOcJYe4Nt45tSQxWWiuKy2vpPfOAC3JtuvF93b0v7FAw
         IfbZR413Ip3HET7NQP8ddc9Cj4Sf/jDmGgSKpfk2NeocGyjxssdx0bZT6Ti6j5Ix1xQ4
         dMWvIQSvwfK08Nl44JDXS/9EUQ9LIwfxgaXviMXcf+g+9f2ifwbGHKU8KWqF0OTon3FX
         l77zk5ZE6Mx/zjBW1Qlv60BBqxagM5L92EnJYyS3PaO8WO04JyC8R/ucoUlDCCRQqkZG
         2Y4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YTc4eaTqTCWWXmcCsM9hd8rF0EjF2lDAr6pE9wv6n6k=;
        fh=xEGvVHfMZuwTzQeHIwmVGtI+KONLnPkvlyGfo5gFwZI=;
        b=OIAWssUkyfCBitZlWRsgQ36ykBpNROSDjZ5eFqkCgD6iJVgoJB2yLE8k8lcirAs6r6
         zPZphYy4cXDu2ViACRVU2QksXn/vVQflagQ07zJvkh7iSK8E+BR1U+Iq2JW6W6TmxSfa
         8ujVexAmHxyenos55BDX1/pAiXaAzAMM5bfXb3S9fdjuQqglznjcyZSVkVP+vuGbnxmA
         Pen5Za+uhmCaEbQVV2hEcWlvevfjDgigoCyZQ1YMHHSkDgIn+kUPUx0+UYFEFlC23MQ4
         EACvT+5DwvYNN6IlxALxOq7FKEXKe50DWHXbfDJyqXMO8mtpJjOBeYsA8OnydjuNm/bp
         7sDQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789994611; x=1790599411; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YTc4eaTqTCWWXmcCsM9hd8rF0EjF2lDAr6pE9wv6n6k=;
        b=XLH4tZPzmOV+NqOKx5lLL/gOxsKtsBE2mwoc6Q73xVZPR2bPlDG0t7g3ZmRImh4+Mj
         R74395dKvBve+MNOCQQ0a94mJ48zN7mY7+KOmh/EaeAaLdDI/RekAVQ23BcnG3AA+luU
         K6NKGOShx/WtQ/8fBaEvJ44dQbjN6R4EJglSdtX3+pgOqYOinF1PeQ6dBRUn6ZPCUFo0
         Uy4ZVMeSgTHTQ0GIfL2IaTOZxBcCBTKfmxul8hMTYgStDZtAPyGuy9iEpVY5qiuYdSwl
         DFu7HFu4a8bqs4tSB6GjsFUZUXJ/0F0LfcpP83ZkxTYy5QX4e2o8/ymqIYve4ewHAUTZ
         5Iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789994611; x=1790599411;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YTc4eaTqTCWWXmcCsM9hd8rF0EjF2lDAr6pE9wv6n6k=;
        b=A+l6eVORY/HMMVQuugeugD1CRpiQp96DV95WAEj66CyjvWVhuyf/D6yFwVGa++uQfP
         8Ejva0tR5gu14tnSAJEssgdHhaJmpka7rqfs5/1rkLUWWpJei7g1FBA6u0tqi9OFMDrm
         Lcoi0UFpo3BrLl1eKLq1AleBSQ5sZiJdbDib9S7bOm3qKIrFr/tEAXFj7zKfftmOmliP
         0bI0zFi5irMNS7shuZbiMF27Qn7JK9Z3hYE+vVsFBhJek8f70sPJXj4dAOWOBiGKElJc
         gQJZd4OHS0Qm6cbcOwB7LlCanPMpCoI4K7PSBuym7V5CnoLjOAgw90xcZunMN9Ad0z0z
         ajlA==
X-Forwarded-Encrypted: i=1; AKwUvByJng+lrxs98Vvj4A9z9xTAUxo5OZHI/+cGgMmv6syYExn8WwApgcGTa3UycHpuu9tRU4rang==@lists.linux.dev
X-Gm-Message-State: AFuF++n+XPixMQayaA4WXcvF/EMUpLjl7VXPcfGKTKcFVN821p2uiwBE
	KDYzxViY6BvX/UQtipNPl1ALu4APs1qlV/J1RTTgQ2EHGXELR6/Rlk+X1iS07urBIN+87aOXCh+
	4UoMVenXIDZu6kTDBmtH2WLibaM8m5/WGWlIr/etv4HdIG5Fne39CxSfxpj3HIdhTfk14SbFDRs
	x9nbbaJ2WDg3bhg32vIElNb+rMK/rewOur
X-Gm-Gg: AYBFou325l2wr6zFaxCXEzWVMobhff7vD0ZpOPkwlrT2baoZLwNDhyu9ERrdqK6ZmFL
	y9bicE27Pl4Y9pRlllBeC2jTXysSzazo2H3qEw6tK+ADd9Xl8kmHb7m5LVez2+cHLZ24EVA+uyN
	/8GSCLHCr0IgV1e2EOrKzrPCFvp7xLaBQw07q9ZfZq+TMuJZ1tbqAOsRyIcg==
X-Received: by 2002:a17:903:2349:b0:2dd:c100:424e with SMTP id d9443c01a7336-2ddc10044e2mr89288695ad.50.1789994611230;
        Mon, 21 Sep 2026 05:43:31 -0700 (PDT)
X-Received: by 2002:a17:903:2349:b0:2dd:c100:424e with SMTP id
 d9443c01a7336-2ddc10044e2mr89288245ad.50.1789994610661; Mon, 21 Sep 2026
 05:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260915104328.45901-1-gahing@gahingwoo.com> <20260915104328.45901-11-gahing@gahingwoo.com>
In-Reply-To: <20260915104328.45901-11-gahing@gahingwoo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:43:19 +0200
X-Gm-Features: AcwNN1XRM4Zpoe9SV6Ox1cb4qr0Qhj7z7Tg6kKrM_v7MoPDIacNjWOamn5qOldA
Message-ID: <CAPx+jO_MFkUrzRDnuoqn_yKntRc_NqPs=0nda6wC_xgb+Fy7bw@mail.gmail.com>
Subject: Re: [PATCH v13 10/14] pmdomain: rockchip: cycle optional power-domain
 resets on power-on
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
        p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com,
        royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
        sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
        u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
        diederik@cknow-tech.com, alchark@flipper.net,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4MiBTYWx0ZWRfX5ovCBDy43/cb
 rOrO3pDc1Z0kNfQu6ewfcjnoVMIeDRnGDtv/s9V3HnH7I/IwWOvmWSo0FgTrmacHfKq6sPxQZdL
 c5/+hKWSXHJ75E4WLmlpWTB6jVNfPz0=
X-Proofpoint-GUID: bT6TyoyIuvHKgJqhNkOg-I3s4rDJOJpc
X-Authority-Analysis: v=2.4 cv=QovLTlyd c=1 sm=1 tr=0 ts=6ab12673 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=9GNsruGHAAAA:8 a=EUspDBNiAAAA:8
 a=xnVI1lRHtBAIIYlgu6QA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4MiBTYWx0ZWRfXzSkjngWdYNhW
 WOegWdybV8cGqORERbHv9a0Z6uEnkChpkKuIaL3MhsIuUi6rhvPUZhk3NanSK/NuM+SSfTWS9oW
 nfNu59Ag6BUZSXd9C2WoxZeL1RahYVwoFbl7hf/8uNRjN41ErG62RaLAl5dTawfnkfJltPsQkGo
 R21s6YRemjKtyMvY2Wq8SdrTuli1cxfT3APJ59WS83V3AHjo7JCVsZ6ha3QvjTegkUHbbJDzast
 ML+LRQenBfDsHsn6d2qJo4pk6Q2QR7kM0Nh/IC/LlewcMD5kR54M7/ZlxlwqTXS4QVpEgzgZdjC
 yry0FQALKR5eOBR8nYKialjjTBkIhPNfC3gn8KvMMuiQpCugiLXN2E1jsnexeV/Lh43+tTMUoTi
 qa7UaPRkUx/PB+ALTx8CNT86mOPMNBSjzTRMpMfGBIZC+5Td/MbU1OH/Ux60UvX9jzOdt4J9c0Q
 GTssMAY89tslsHrkDUw==
X-Proofpoint-ORIG-GUID: bT6TyoyIuvHKgJqhNkOg-I3s4rDJOJpc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210182

On Tue, Sep 15, 2026 at 12:45=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> =
wrote:
>
> Some Rockchip domains come out of power-on with their bus interface in an
> undefined state. On the RK3576 NPU this shows up as a hang on the first
> register access after the domain is switched on, and pulsing the domain's
> resets at this point clears it.
>
> Take the domain node's resets if it has any, and pulse them between
> releasing idle and restoring QoS. The resets are optional, so domains tha=
t
> do not list any are unaffected.

Please drop the below from the commit message, the above is clear
enough I think!

>
> The cycle goes before the settle delay 9/14 adds, not after it. A domain
> that asks for both is asking to settle before the QoS registers answer, a=
nd
> a reset deasserted after the delay would leave nothing between the deasse=
rt
> and rockchip_pmu_restore_qos(). On RK3576 PD_NPU0 and PD_NPU1 ask for bot=
h,
> and the reset they cycle is SRST_A_RKNN0/1_BIU, the bus interface those Q=
oS
> writes go through.
>
> It only runs when the domain actually changes state: rockchip_pd_power()
> returns early when the hardware already reads the state being asked for. =
A
> bootloader that leaves the NPU powered would therefore skip both this and
> the delay, which is why 9/14 gives RK3576_PD_NPU need_regulator and force=
s
> the domain off at probe.
>
> No in-tree DTS puts resets in a power-domain node today, so every other
> Rockchip SoC takes the optional get's NULL and is unchanged.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Kind regards
Uffe

> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 39988efd8..6cc8d6efd 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -19,6 +19,7 @@
>  #include <linux/of_clk.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/reset.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/mfd/syscon.h>
> @@ -103,6 +104,7 @@ struct rockchip_pm_domain {
>         struct clk_bulk_data *clks;
>         struct device_node *node;
>         struct regulator *supply;
> +       struct reset_control *resets;
>  };
>
>  struct rockchip_pmu {
> @@ -688,6 +690,21 @@ static int rockchip_pd_power(struct rockchip_pm_doma=
in *pd, bool power_on)
>                 if (ret < 0)
>                         goto out;
>
> +               /*
> +                * Optional: some domains need their resets cycled once p=
ower
> +                * is on. This goes BEFORE the settle delay, not after: a
> +                * domain that asks for both is asking to settle before t=
he
> +                * QoS registers answer, and a reset deasserted after the
> +                * delay would leave nothing between it and the QoS write=
s.
> +                * On RK3576 the reset being cycled is the NPU core's bus
> +                * interface, which is what those writes go through.
> +                */
> +               if (pd->resets) {
> +                       reset_control_assert(pd->resets);
> +                       usleep_range(10, 20);
> +                       reset_control_deassert(pd->resets);
> +               }
> +
>                 /* Some domains need to settle before the QoS registers a=
nswer. */
>                 if (pd->info->delay_us)
>                         udelay(pd->info->delay_us);
> @@ -861,6 +878,14 @@ static int rockchip_pm_add_one_domain(struct rockchi=
p_pmu *pmu,
>         if (error)
>                 goto err_put_clocks;
>
> +       pd->resets =3D of_reset_control_array_get_optional_exclusive(node=
);
> +       if (IS_ERR(pd->resets)) {
> +               error =3D dev_err_probe(pmu->dev, PTR_ERR(pd->resets),
> +                                     "%pOFn: failed to get resets\n", no=
de);
> +               pd->resets =3D NULL;
> +               goto err_unprepare_clocks;
> +       }
> +
>         pd->num_qos =3D of_count_phandle_with_args(node, "pm_qos",
>                                                  NULL);
>
> @@ -931,6 +956,7 @@ static int rockchip_pm_add_one_domain(struct rockchip=
_pmu *pmu,
>         clk_bulk_unprepare(pd->num_clks, pd->clks);
>  err_put_clocks:
>         clk_bulk_put(pd->num_clks, pd->clks);
> +       reset_control_put(pd->resets);
>         return error;
>  }
>
> @@ -949,6 +975,7 @@ static void rockchip_pm_remove_one_domain(struct rock=
chip_pm_domain *pd)
>
>         clk_bulk_unprepare(pd->num_clks, pd->clks);
>         clk_bulk_put(pd->num_clks, pd->clks);
> +       reset_control_put(pd->resets);
>
>         /* protect the zeroing of pm->num_clks */
>         mutex_lock(&pd->pmu->mutex);
> --
> 2.43.0
>
