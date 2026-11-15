Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794748606;
	b=yCGCj6kRFmkUKrxe8t86sw8fi6Bw3jJ/86x9jNmCpDMcyHFi4/SpaT9RYWSeTyM7i7gs
	 /G5TWQtWq4G+L+s8/WQadwJUmKpO4RvN87IoDyPDuHTJL3ydogvlQmrpCPIos7ctV5Ope
	 1PeMkfdjV461gKQG88/IlgO0feFqJOWtWCpRmceQuuEhva6wR+VbR1xUEgMOMQXm/clOm
	 bYXpx1C2ePNB7G4Ggrplx4OycqZfmjkkpoOsxnOgosf8421kVrK0Bwsp3XKwthT+0rTf2
	 ccWQxWuR1+/Kr4dswaayKBUnlmXOlP0ucq6zex8h16UeOZMEDXWTI/RUgYqKitsKe2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794748606;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=P/iZWwmcm3GJ6CC8MhWTY8Sc2xzYlGTS5W4HDt6HJ9I=;
	b=FQ7CnEsj+4apaXUcPWQT3kGNblsQvW1jMRPIJ6D7kKaJsxRLteHhh0fdVRXboyIq6iAx
	 E3vBop9mLKAmYMJtkAhynWyLccEUl69wU0/t+HCHZZ3DBcZjLGfzXLxNjqAViuzo/P5Ct
	 ULU+OMGjVhGtGRBW/G/AbiDwTufS4FgnC9iqiAOP3KuIWT0XamVUjNkFSlB4joRoQPqLE
	 cdh9xz4MqBj/r3znq+w/XaxUI16yTp58jaJe3q93dok+g7mVyeCsYUvNB0kb5B/66eL4J
	 W7AFYpg9lJaVJ2EDm0R54VHNSA4Cl7ipVzYr2LxUuE6rN2SUtVyR5NLvYC89iJLyUTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=lAbr702A;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0433F606A31A;
	Sun, 15 Nov 2026 13:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0433F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=lAbr702A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=P/iZWwmcm3GJ6CC8MhWTY8Sc2xzYlGTS5W4HDt6HJ9I=; b=lAbr702A7r84NtQz1gujPywg4k
	yBT3Z0xSGQanL5I3/5xJUV+0Kw/mxXBjjQVHsF+Y65CpJPrGrjj1WvwqFPn/FKwmPvq28ATkzAryg
	7Il7K3vQmQ1CdSmPyCIxYdECs6NT761RlmgOQBsDViniBQ5rzBTlw58PiveEVMo7haTgv61jeyIWI
	wJDMN5VktCHa8leoByjVNmFuI9VrXrjzsNIRgbElQ8vk6JixqXyqygiUu7WCRi7OvhFpEVj+F3lRq
	xMrKretk6AlxK4EUzCTFqOaMsKlh0xRYsvyxrfiP4VxUeNPBrT33PkZRK3gl36hQ/BLdHMD07Asxf
	f+pybMTA==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com,
 Jiaxing Hu <gahing@gahingwoo.com>
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v17 03/12] accel/rocket: wait for a running IRQ handler before
 resetting a core
Date: Sun, 15 Nov 2026 14:16:01 +0100
Message-ID: <hvfzY-vMTP2qEvT5CAWuhg@sntech.de>
In-Reply-To:
 <18667b2afdcaae217fa1038f5348ab23ed756bdc.1794615323.git.gahing@gahingwoo.com>
References:
 <cover.1794615324.git.gahing@gahingwoo.com>
 <18667b2afdcaae217fa1038f5348ab23ed756bdc.1794615323.git.gahing@gahingwoo.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Samstag, 14. November 2026, 04:05:20 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Jiaxing Hu:
> drm_sched_stop() does not wait for a threaded IRQ handler that is already
> running, so call synchronize_irq() after it to make sure the handler has
> finished before the reset.
>=20
> Before synchronize_irq(), mask the interrupt and clear the raw status, so
> that the NPU core cannot report a completion afterwards.
>=20
> Do this under job_lock, because the submit path sets the interrupt mask
> under the same lock.
>=20
> Only touch these registers when the device is powered: check with
> pm_runtime_get_if_active(), so that a register access with the power
> domain off cannot raise an SError.
>=20
> Suggested-by: Igor Paunovic <royalnet026@gmail.com>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, i=
nduced reset, JOB_TIMEOUT_MS=3D2

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


