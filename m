Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602252;
	b=OtIYKBxPFUkgiY0Cpe5PWHOMkWOxyHebuwCFK6JAxS2LiwEQbF4P6fYfLO513+yhP8h9
	 eXzwW/5EnBXzTUPLHkBrSVgmMqjqiHc5CFSIPZS9LOdeonHfOPpmBhswGAOALfrBeVFpH
	 QUgKkKhXAFf6rZe6qKvq2yqsAVOtANy12F8PqQ1ILhEY5e0iPlWDThkLRmwN6/SzClQqg
	 SpgUeT8oh792d4MX002MMh7R2VZl4ULtxz6iTMr3X3l+bvb6HId9TVB4iIxqFwZOCqA3e
	 QN5vLI7I13gtTyE9sTPNO6GNuaNKjWCDM5YRUO+71q6XMYQ8cA5zS8RvmZ2Xy+zMr7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:CC:
	 Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=qfsFhryTTz4RhXxObQ1YZegBdEDgfWhPId1rtPYAN/0=;
	b=soz7eArKq8F8a/wopSzW7xHGGV0TRpjfvNnKN13H7dEd6GYTsC3kze0e2RS2nNNjpxYF
	 RJGnRiFjQJE+a2lR1qkghoknTO7nFlRhpdjBzaxRCIzCOkI0dCPVdL5PhDlApQxRNlxi4
	 NLQAe1cNDGMh3PN9qrizL9PECHJdB+Rz5Veynie8VRVq1qh/EYJT4ltyg6CJX6/d3rwrM
	 TmS684ROVO9ZPmLwFGP83EmLgNlB/ChTcAHxRpHyxT0YD4atqdozyojyS9osxLK3AW5gz
	 O0MyjB1aHij5EBlT7JBtbZ+vfZV+klsZ6GM61lvVYUm6fBdaYiI3K5rUNd7zZtfj9tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dWgwFIem;
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B676606A335
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 17:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B676606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dWgwFIem
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6740e7ae219so849197d50.1
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 10:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792602251; x=1793207051; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qfsFhryTTz4RhXxObQ1YZegBdEDgfWhPId1rtPYAN/0=;
        b=dWgwFIemFI3vFX4HLANEC/bRzZCiOcF42sTf09gRpnvwVjPhdd5qVn9pUB6ddJtYER
         lsYBZoTMjeCuoyhCP6Celeh57MhgbqaPne/yPTGgDSsgXJNzE111wdjhl22AGFVj6Vqx
         kFD5k1SsljKafibuLomaZqNighnByczjCgvUpa6waE3+JUH65fNwa9d4FZ1QsnmUymxM
         12NUS+R6APReERrEEcyNqtUnPAZ34t7NnXUX5Aul3DsFdc11nZAXPhI/FNby7nn/HKRC
         c1qL3Vw/G7wu2QUHq6mGxJvrI4e/d/CLuRoVD2LQPVkbr6LmeG1eY92AgkVedXxLNMjN
         v41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602251; x=1793207051;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qfsFhryTTz4RhXxObQ1YZegBdEDgfWhPId1rtPYAN/0=;
        b=DyiYw8Ml+zHNdmv0BJo+r128DkuIeW+qiEichojiRVGjh25/6IECuBdtw4GfP35LiK
         X/GeJGVWPpMqmeCfHUEMPhRZmV4RByyv5U46OY89U1RQ0C9PwrI+HtZSEX7h9HzfAY6G
         W0833lEVnMkFIGcyDrR8k3MQOFZQf4AYzmo+lIZJHu4NI7Emm7H2aPc8UtJBoNsTwEqt
         AGYXdeJEjbuAPSe1LFUm48a3Z2tf32kLT6AUC+rW6KGB59vhg/MerlzVjxOG5jV8VarM
         bIZTA7U2n/qF1oMYJsVj40BfbHOG+NXdyONRYrJdUn4014c7vGjrc7VZ9U5yN0q6YxfE
         jWVA==
X-Gm-Message-State: AFq9FYKbAlf7ekWERdk9cMDgVF2bEwb0zlCHM+oslij4Ja9wfiuL07ra
	tAi/7kFYW+1j6+eroLPXmn5PJ1vykPU//UwxW87zut+yhzM5N4CPzQqh
X-Gm-Gg: AYBFou0xyvJ157pU6PLnyMJTmRvCb/yviPSIcYH1Xo0KFQ7+hlDZvnegoeGSUP66Lg7
	V1BIEtpLwHsTkRtM5FXQ7Pxx/3zX0lFvPXo2nSVJxZmI2eFKb4R1HnZvgDnICIB4WBKvdzOb0oS
	0CEKu0GIsKTFzaMjJJRuVcM2Sz2VlPrBGbY84MabcRGfH5vZgC2UkMtRvwb2i45LeBiiAjkWkMt
	aOjICSYeTfDsezeP6Vzeyi+KZVBF2fDJK4WbeSebb4yrCnentWyTa30+jzmY+dlUdpwe87rOL6n
	J8tDC7mD3w7ZDYP0qDe48lRKn0hhkftv4syrsLbrH33H4nntUMzns9BvXEGUWxNPfRhSn5xRToM
	2FF25PACZnuPf520VLswBW/FNGYByhMmD+2UR66cQ5aVvxFpciYCoz7xS5Ra38qANrp5kwdLO3v
	T7ASrCRymdB2rJ7qjxkBjtDscPA5TaT7gjr0vKS31dsIS5R5yeXVHO49ETV0MCZTN+i9zc4ZAi6
	TP73X3uqe44mDI5h5ilKfma30qbvYjEmNvxYpjbe2S59qzw/Pp0DXAA4MCz8gtcStPbXyrsw2C7
	3dtqT3u9MNfIcC7NoeJJvvBQrqiNCgUm7e/Mh/++kkZR86kLaGobHcvj3aZCeM19AyFBBj7Ee5E
	0UZ07P8EZW99P58nU1LULHe6KL4JD4LyyFUuBWPqmT0GdIYTkwDpL2//7oceom/c=
X-Received: by 2002:a05:690e:1512:b0:679:cbd7:b72b with SMTP id 956f58d0204a3-67a0e56be30mr733933d50.131.1792602250958;
        Wed, 21 Oct 2026 10:04:10 -0700 (PDT)
Received: from ehlo.thunderbird.net (212.153.88.200.l.sta.codetel.net.do. [200.88.153.212])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a0e491a8dsm1417854d50.8.2026.10.21.10.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 10:04:09 -0700 (PDT)
Date: Wed, 21 Oct 2026 13:04:04 -0400
From: Jason Perlow <jperlow@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Aditya Garg <aditya.garg@linux.dev>,
 dwmw2@infradead.org
CC: iommu@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
 johannes@sipsolutions.net
Subject: =?US-ASCII?Q?Re=3A_intel-iommu=3A_DMAR_PTE_Read_fault?=
 =?US-ASCII?Q?_crash-loops_a_PCIe_wifi_device=2C_v7=2E?=
 =?US-ASCII?Q?3-rc7_-=3E_v7=2E3_final_regression=2C_repr?=
 =?US-ASCII?Q?oduces_on_one_unit_out_of_five_tested?=
User-Agent: Thunderbird for Android
In-Reply-To: <1a15f52cf68.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <CABZrw2GfC8SEPiGOUD42um57nKZAghjHz8N1DhMsw8sOC7OAxA@mail.gmail.com> <2c840dcf-4292-4579-a62d-f9766b7cb780@linux.intel.com> <74570358-8085-4767-BF76-D865CA95853E@gmail.com> <40118d49-2e79-45c7-8e50-58e05a44d24d@broadcom.com> <EDE0E273-27FD-4069-9129-FCBB48D12ABB@gmail.com> <1a15f52cf68.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Message-ID: <20F90036-F53C-4490-B27A-DFD055DB22E8@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable




>
>I would prefer the above in proper patch, but it's up to Johannes=2E
>
>Regards,
>Arend
>
>
>
Patch below=2E

-- >8 --
Subject: [PATCH] wifi: brcmfmac: map msgbuf RX packet IDs bidirectional

Commit f0ba5fd51ff2 ("wifi: brcmfmac: Set DMA direction for msgbuf
packet IDs") maps the RX packet ID buffers DMA_FROM_DEVICE=2E The
BCM4364 firmware also reads posted RX buffers, so with VT-d
translation enabled every such read faults ("PTE Read access is not
set") and the firmware crashes and resets in a loop=2E

Map the RX pool DMA_BIDIRECTIONAL again, as before that commit=2E TX
keeps DMA_TO_DEVICE=2E

Fixes: f0ba5fd51ff2 ("wifi: brcmfmac: Set DMA direction for msgbuf packet =
IDs")
Cc: stable@vger=2Ekernel=2Eorg
Tested-by: Jason Perlow <jperlow@gmail=2Ecom>
Signed-off-by: Jason Perlow <jperlow@gmail=2Ecom>
---
drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf=2Ec | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf=2Ec b=
/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf=2Ec
index 069ba70=2E=2Eff47d48 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf=2Ec
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf=2Ec
@@ -1639,7 +1639,7 @@ int brcmf_proto_msgbuf_attach(struct brcmf_pub *drvr=
)
if (!msgbuf->tx_pktids)
goto fail;
msgbuf->rx_pktids =3D brcmf_msgbuf_init_pktids(NR_RX_PKTIDS,
- DMA_FROM_DEVICE);
+ DMA_BIDIRECTIONAL);
if (!msgbuf->rx_pktids)
goto fail;

