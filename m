Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795691118;
	b=gFDxZ4frxDYQReAs95TSG2g11Qj6nqICiC2c22u1Pbl4mvmIoYKpojhqUXyqmliDkfg6
	 pD+Ss77rfr4khPAn6UCMg9ST8wVrmmjPC1sdlcfCq/FLNfybLEdpVylihpJiKR1McHuA/
	 kq3tb7+gSK4E1nUyk0RT+5iwks02GFB+jqAJ9gJ/SArTbm6jSIMrezLNvAOkfhWFl8IhL
	 AFddy+aMdfgl1ouZ2pX7DSInmYkEBdkLEi46hQWTrcRXVnf23rb6mMAXKFHUrI1GyX87W
	 ss8B766yZWJDNfpeFRqhN9rtqF7dK9bJgVEkDVlCkBNtKGxcIfYlbjevYv8uhHq/OmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691118;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=g1svp5E9pb1rvrFjE3ldylGmmn2srl47JCoHJgVCeZs=;
	b=1VBR3KDR+9yLTQpuFMTOMSt6VlevPMB/sygFp7vTvLtRqxtSIVggJuoj6JoeF88iFTHp
	 EGceRLP2cqADcrYpxVDDg2PRzIPMQVjXFYr9TuJLzRJ95fnjijLPHuL/OiHlXl5JSYYgI
	 kBPpG1Wd1UqqMecvusyWXQafpF/sl/DO0JRJax5dA8ZPqwyphVCx9YS/DiegLTpB4X2kw
	 RuSgGPnPTQ3FMLG1Qn3dt0YT2zCChGFgptiEx1fdTzLE7ekXMI1i9/EKnzoiKlymgREih
	 GveMWWb0NJ7fNrmNPrhYrADPu7XAiBZB9i1Ao5AukqT61jJg/pGoZrG9cVVtgbwKX1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P1LCYAuM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gZcGbQKY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B930606A326
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 11:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B930606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P1LCYAuM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gZcGbQKY
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQAXLWR1369989
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 11:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g1svp5E9pb1rvrFjE3ldylGmmn2srl47JCoHJgVCeZs=; b=P1LCYAuMr/D5qPTC
	qvoMVcOhInukkngJQPbRRoVLIxCrm3Cbfltg0ixbMdjOrOCz28lnsbK/FQbX9Kxo
	BkB6bDX3zRnt8Lih15T2VcTNv3NsYAZmdBNcGIxrJ9waXYUlSRR2c5ItayhUE+Lj
	UIJqi1GcDJuTJV8n5mrLlU/qf/cOXHqVrbFPCDN4b0Cqz9iwZUQbDA+S+IHfUpR7
	ZaGPJrzmcNTomoKTKw6DtX4u+/Ex32UNVMKqo5Hvrp3sL161tdjQ+yWKRBUIzIeB
	VPjhRhXeaJs2curePdUvH8qZN14pakXXbheUUye90cMh2duVMtLEbyyacpM8Tti8
	AevJyw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662y2s6v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 11:05:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b4139b7abcso6101015a91.3
        for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 03:05:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795691117; cv=none;
        d=google.com; s=arc-20260327;
        b=SxcLjCvgp6rI7hLKXQIqB8Rugh0EU+1gpviy20Tsw8w1kuIKbSYGae/QpmT/bGYTUj
         f1yxVxclWXlvSHdRmaIBkKRKjBbv6lOJb5rntafU+y2eeH7NJcWGQr5tvqN9TWTMxGUf
         WV36CKsCO+qXTzIWXTKxHETkVUUa82MZM17xBb9C3YEGgTHDTTnMQUnzJZhS0bMqmQfB
         Mu8MJhJJm9mxXZwvE1dUpEoaqEtpemxkcfJWrWGbrONIO5v3zdxH5bbGhSkgx/w3bD2P
         TXnkh6+mpyu+aditkw5oKww8inKPmcYmkIXoakM+KenAKb1ZxIYUSffRO+cIn1OV6y7Y
         ny/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g1svp5E9pb1rvrFjE3ldylGmmn2srl47JCoHJgVCeZs=;
        fh=lNcy9jNibOwpf1jsaFYbbCNb5ij9hasW0wMCEjZyC5o=;
        b=kH5+1lZVTY6J6BWgEHUih70LLEFf/GRuWVG/RaML3Sm+Gdja8/LMZf6benuIfDYTYe
         VFKbqmlRx6ei0/5YN+T2cEG5cmEh3YF10Mqu/xv1xWPtPv/LLey37HRMJ3NKftPeHhdM
         oovOkse2fDdCmwENykngkIfCezwvRO7AeFBapjclfsnyQKes8BmVIGWZxTXVwqnLuz23
         +9jRckCylRPIRP72690Z2ofu2EUbcsSRoF6O/qx+OlN2b4aRnOM2aSguBUP0BbliBCnB
         Un8xLRZR16L0HVn9Zut5jjwgaNRG1JLh1B244XTHppHdRppxIFF/Dp9ARqLld02wsQAd
         fMZQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795691117; x=1796295917; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g1svp5E9pb1rvrFjE3ldylGmmn2srl47JCoHJgVCeZs=;
        b=gZcGbQKYNj13quXEfE3rw/HEe6g37VnsExrI/HJdp4HH5X7f9Zj1tDDLd2PdWFI7NI
         6tpxevALkplPbytSUjCYSlYegig2I/INMCvjNj19yXPogRhcIrnLn72PRh6rqB8LkRXC
         5U7398ckRgQz+I9UlnWPXlYjoCeBkSv+dJfvca2MXFGz/MCZOOHxj7EAXjrb+pB4CUxG
         9tKVWMDh8845T53uPhCrfhaDPPOnTLTZrYSUf8Vx9wUMdE/2k53CBLriHRNphIFflken
         P/jgYJ+hIEWFxuYL93SPp9NQ/nXiIm/yeN8dPuXh9auEhEdBGSnOdAesSnk57azi2yS9
         Tntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795691117; x=1796295917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g1svp5E9pb1rvrFjE3ldylGmmn2srl47JCoHJgVCeZs=;
        b=LliDYevz8uhKvvYf+EBH8XphBRH480A7E+rXFE+ZP+lovuf3s9v4TMM7LqkgWotqna
         KMLd1gM+tAujKPf6j1FBt9bgEFrSMhQmh5w4Ha6Z7ccIQ8fJO+CuyNu37cVGCrqTKeq9
         JJ/n1YMddroGo5+mGfmYGDAWyuGCbPuLJuhprxToJKFJkyGxim1W3K6DLXZqEenKQk+9
         mgmw76tkcHxVlw0ktDz/UiWQXLs4zn/7DSFWKLBw2v1ZbFVMN9GGwBijbEWX3hgaHqeS
         WqkTz3C+ZXjfniO0+lgF/3xvo9NDXW0PNvDX38k6lI2pqi1l/ieTXelhEQ+ucDW+otTv
         p6KA==
X-Forwarded-Encrypted: i=1; AL+hErHj1H2DJUmmCvibNw7kTAeETrVRU4cJyjELYgK41BDgmtPenQ3aiWzDzaxbfkqp6XmFzo8spA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/jSFtHp65P5oagRcNQkjegC4AhSlRD7zwqyXooqiJS9+xcAr6l
	M4jX/L5q6WrpDZkabcn6WUND9LkrBtYL6BcTnxxjAASQ7IZ/YM3qZzHOd7OxKiyZPAVramn/oOq
	UGzVw3EHoZbFxy+hdue5NYQp5XbO+qNTRduXL6ALiMvpbSSbsLAjEzSJ2XLVMfM6L17OxQHPwRC
	1Z+PgGWmhwEebNrzqv9zXGRxJ8PfuhfQMu
X-Gm-Gg: AZFdTZceU/ukH4H2peBBs78V2gcPpAFezvTTprMJ2hGV9WW0TY1j6bbFlIHNWsbg8fk
	6DSYHH2FAzKkd036KQaPtG90Z3/eE2xHeGTd/WRvIAdl7+XI+GmKZlPEMdGUZZ54cN0fBKTgR2I
	7o9uY0t7iAC4clLA+9vUSeOFwR5j1hRY5YMASrvAW36fA22mKw9oJSSCIoRQ==
X-Received: by 2002:a17:90a:d2cf:b0:3b3:b595:2473 with SMTP id 98e67ed59e1d1-3b41c906b61mr18544088a91.24.1795691116574;
        Thu, 26 Nov 2026 03:05:16 -0800 (PST)
X-Received: by 2002:a17:90a:d2cf:b0:3b3:b595:2473 with SMTP id
 98e67ed59e1d1-3b41c906b61mr18544043a91.24.1795691115988; Thu, 26 Nov 2026
 03:05:15 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261117173738.1073856-1-Frank.Li@oss.nxp.com>
 <20261117173738.1073856-2-Frank.Li@oss.nxp.com> <CAPx+jO9RwkpSKwq6vq00uoXK-mcovJ2LMH7b_ByRnxOUj8nH8w@mail.gmail.com>
 <CAJZ5v0jsnLjEBxa1R4Q3hZLZKrCUW0xSE9SqLB8bd4tNAhXTAQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jsnLjEBxa1R4Q3hZLZKrCUW0xSE9SqLB8bd4tNAhXTAQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 12:05:02 +0100
X-Gm-Features: Aa3M54r_rMhLGHc1vqQ3FXriLYRwoLb-Xyx7xbWcsA8f-DpP_bkxDUBWaFpBhbQ
Message-ID: <CAPx+jO9JYTygL7F4nc9zb=iOmeKfdpa6-_QBOvAmMN9fp6HfwA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PM: runtime: fix stub pm_runtime_get_if_in_use()
 for !CONFIG_PM
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Frank.Li@oss.nxp.com, Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulfh@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Hans de Goede <hansg@kernel.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, Marek Vasut <marex@denx.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support:Keyword:mediatek" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support:Keyword:mediatek" <linux-mediatek@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support:Keyword:b[Rr]ock[Cc]hipb" <linux-rockchip@lists.infradead.org>,
        imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alessio Belle <alessio.belle@imgtec.com>,
        Luigi Santivetti <luigi.santivetti@imgtec.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        dri-devel@lists.freedesktop.org, imagination@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0MiBTYWx0ZWRfX8tHoEHs0LOid
 vfLmjh/klrelowkjWoFBp+MRRClyRB7pQ3enr/Z63ju8qVEldRjKKkpvCthV61UlprjulXryPEK
 t5hF9GxllnzPtd3hGj2mhhHmMFax+T9rpkJIuwD99acH+80YumdNeixfVdmspuDGdmxqvOK0zDR
 MW87fambChXk1skEptXf4E9/jrcAz7jMLbfGeuLNfs6KuEu2m2Bz5XJ0bKGI2WrTi2rJQXHWGMo
 SEZtxWzwtanJLPxxPvHUFXQQi7Un2ed73ZJBCjmqL0EWePwSmIHh/ima5I1mked9NYtmgvwtw3B
 ZjYhbhHnGyy548c0lizNPTjowhHfB7D7IKEsiBTiRK83TbU6HUSrXlx5x/LK1uPvHrLlvNgk1Go
 H/M/o2YALTfMfztbR9B3Vbk9OsGiodkWAxxGh2kFg2Ddvso7yHfPJLVQML73Y2wnJeIozs84trk
 D2IQmeZeFWqNWqdOIZw==
X-Proofpoint-GUID: ZRNqJPCdZCSx9oknuk6m_x2ao8IgpJAx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0MiBTYWx0ZWRfX5Knfqa5KAqjv
 JJ/bNTvvZg9PXhHQCYt4rALWjx25b/5OokC+YnZxH4NLkdeyoP1Z+npqVQHco5PFokNnOU3I5jj
 mg6SLkwBa/aGkZ3dz/sNixO4qVgqOu8=
X-Proofpoint-ORIG-GUID: ZRNqJPCdZCSx9oknuk6m_x2ao8IgpJAx
X-Authority-Analysis: v=2.4 cv=W/KtxhWk c=1 sm=1 tr=0 ts=6b08126d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8
 a=QyXUC8HyAAAA:8 a=GFqr32JmAAAA:8 a=pGLkceISAAAA:8 a=r_1tXGB3AAAA:8
 a=iox4zFpeAAAA:8 a=7CQSdrXTAAAA:8 a=mpaa-ttXAAAA:8 a=QX4gbG5DAAAA:8
 a=ZLGELXoPAAAA:8 a=P1BnusSwAAAA:8 a=zd2uoN0lAAAA:8 a=e5mUnYsNAAAA:8
 a=JfrnYn6hAAAA:8 a=foHCeV_ZAAAA:8 a=x6yKa4QoHz4R4KwlW4MA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=ST-jHhOKWsTCqRlWije3:22 a=f02Ha7HRcztGgdyUxOxW:22
 a=t8nPyN_e6usw4ciXM-Pk:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=AbAUZ8qAyYyZVLSsDulk:22 a=CFiPc5v16LZhaT-MVE1c:22 a=D0XLA9XvdZm18NrgonBM:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=1CNFftbPRP8L7MoqJWF3:22 a=h8a9FgHX5U4dIE3jaWyr:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260042

On Wed, Nov 25, 2026 at 4:53=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Wed, Nov 25, 2026 at 4:07=E2=80=AFPM Ulf Hansson
> <ulf.hansson@oss.qualcomm.com> wrote:
> >
> > On Tue, Nov 17, 2026 at 6:38=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
> > >
> > > From: Frank Li <Frank.Li@nxp.com>
> > >
> > > The stub for pm_runtime_get_if_in_use() under !CONFIG_PM currently
> > > returns -EINVAL.  The real implementation returns:
> > >   1  - device is active and its usage counter is non-zero (bumped)
> > >   0  - device is not in use or not active (counter not bumped)
> > >  -EINVAL - runtime PM disabled for this device
> > >
> > > When CONFIG_PM is not set every device is permanently "active" and
> > > always considered "in use", so the stub must return 1, mirroring
> > > __pm_runtime_resume() which already returns 1 in the same build.
> > >
> > > Returning -EINVAL breaks callers that test the return value with
> > > comparisons other than "!=3D 0 / =3D=3D 0":
> > >
> > > drivers/gpu/drm/i915/intel_runtime_pm.c:
> > >   if (intel_runtime_pm_get_if_in_use(rpm))
> > >   which wraps to: ret =3D pm_runtime_get_if_in_use(); return ret > 0;
> > >   With -EINVAL the wrapper returns false, causing an incorrect error
> > >   path in the GT fence revocation code.
> > >
> > > drivers/gpu/drm/xe/xe_pm.c:
> > >   if (pm_runtime_get_if_in_use(xe->drm.dev) > 0)
> > >   With -EINVAL the condition is false; xe_pm_runtime_get_if_in_use()
> > >   returns false, so callers believe the device is not usable.
> > >
> > > drivers/gpu/drm/gma500/power.c:
> > >   return pm_runtime_get_if_in_use(dev) =3D=3D 1;
> > >   -EINVAL !=3D 1, so the helper always returns false when !CONFIG_PM.
> > >
> > > drivers/gpu/drm/imagination/pvr_power.c:
> > >   if (pm_runtime_get_if_in_use(...) <=3D 0)
> > >   -EINVAL <=3D 0 is true, so the driver always takes the "requeue" er=
ror
> > >   path instead of proceeding with the active device.
> > >
> > > sound/soc/sof/debug.c:
> > >   if (pm_runtime_get_if_in_use(sdev->dev) =3D=3D 1)
> > >   -EINVAL !=3D 1, so d3_prevented is never set, corrupting exception
> > >   debug accounting.
> > >
> > > drivers/iommu/mtk_iommu.c:
> > >   if (pm_runtime_get_if_in_use(dom->plat_dev->dev) <=3D 0)
> > >   -EINVAL <=3D 0 skips the TLB flush, leaving stale IOMMU mappings.
> > >
> > > drivers/iommu/rockchip-iommu.c:
> > >   Three call sites use WARN_ON_ONCE(err < 0) or similar patterns.
> > >   -EINVAL < 0 triggers a spurious WARNING on every call.
> > >
> > > drivers/media/i2c/isl7998x.c:
> > >   if (pm_runtime_get_if_in_use(dev) <=3D 0)  (two call sites)
> > >   -EINVAL <=3D 0 causes the driver to always skip register programmin=
g
> > >   when !CONFIG_PM.
> > >
> > > drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c:
> > >   if (pm_runtime_get_if_in_use(dev) <=3D 0)  (two call sites)
> > >   -EINVAL <=3D 0 prevents any debug statistics from being collected.
> > >
> > > Fixes: a436b6a19f57 ("PM / runtime: Add new helper for conditional us=
age count incrementation")
> > > Fixes: 3b85b7bcccf4 ("drm/xe: Fix display runtime_pm handling")
> > > Fixes: 672c473576ca ("drm/gma500: Rewrite power management code")
> > > Fixes: b30289e7fa92 ("ASoC: SOF: Fix runtime pm usage counter balance=
 after fw exception")
> > > Fixes: c0b57581b73b ("iommu/mediatek: Add power-domain operation")
> > > Fixes: 51ef2be546e2 ("media: i2c: isl7998x: Add driver for Intersil I=
SL7998x")
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Change in v3
> > > - drop tag: cbb819c363c5 ("media: rkisp1: debug: Collect input status=
 by sampling ISP_FLAGS_SHD")
> > > selected PM at arch config
> > > - drop tag: 0f181d3cf7d9 ("iommu/rockchip: Add runtime PM support")
> > > selected PM at arch config
> > > - drop tag: 9d58aa46291d ("drm/i915: Fix the GT fence revocation runt=
ime PM logic")
> > > guard by CONFIG_PM
> > > - drop tag 727538a4bbff ("drm/imagination: Implement power management=
")
> > > depend on PM
> > > `
> > > Change in v2
> > > - new patches.
> > >
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
> > > Cc: Simona Vetter <simona@ffwll.ch>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> > > Cc: Alessio Belle <alessio.belle@imgtec.com>
> > > Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
> > > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Jaroslav Kysela <perex@perex.cz>
> > > Cc: Takashi Iwai <tiwai@suse.com>
> > > Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> > > Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > > Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: Yong Wu <yong.wu@mediatek.com>
> > > Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.c=
om>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > > Cc: Dafna Hirschfeld <dafna@fastmail.com>
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Michael Tretter <m.tretter@pengutronix.de>
> > > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: imagination@lists.freedesktop.org
> > > Cc: intel-gfx@lists.freedesktop.org
> > > Cc: intel-xe@lists.freedesktop.org
> > > Cc: iommu@lists.linux.dev
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-mediatek@lists.infradead.org
> > > Cc: linux-media@vger.kernel.org
> > > Cc: linux-rockchip@lists.infradead.org
> > > Cc: linux-sound@vger.kernel.org
> > > Cc: sound-open-firmware@alsa-project.org
> > > Cc: imx@lists.linux.dev
> > > ---
> > >  include/linux/pm_runtime.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > > index de9e7518ecef2..1d983fe55a16a 100644
> > > --- a/include/linux/pm_runtime.h
> > > +++ b/include/linux/pm_runtime.h
> > > @@ -276,7 +276,7 @@ static inline int pm_schedule_suspend(struct devi=
ce *dev, unsigned int delay)
> > >  }
> > >  static inline int pm_runtime_get_if_in_use(struct device *dev)
> > >  {
> > > -       return -EINVAL;
> > > +       return 1;
> >
> > This should be return 0, as we did not bump the usage count.
>
> This is kind of moot because there is no usage counter.
>
> However, the caller may always take the opportunistic "in use" path
> because there are no potential costs related to it.

Of course, for the !CONFIG_PM case that makes sense.

Please add:

Reviewed-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe
