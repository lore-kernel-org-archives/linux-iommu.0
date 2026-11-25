Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795621765;
	b=cIlojcvMcBt8Vj4xQucn2KNi59Cp86tSnAyU+GwzQHvnedaGMhiwts0qJDIF9dqKkg04
	 QDS/azptxs3V6bVAxPhyddukU0q2DWXMfOi58FhrW4gKK0qxQ+7DFJKd1P89ZCkhGaII9
	 wcWonspM7kvsor8VGDUNUAlTHyva7asKHYYaGJojiGsVaABCDIeqBgqfs1Ce84B6oNMr0
	 2bPG416l35go3jCdpPKECn5gFN6AXCGtLVIKg8Ta/TL+bd3MGbKonfoHKZLMfkdSuGPfj
	 DG2umkWxZeYvRqo5CXSwi83+zjFRdALoJM+4EmoWO6FOgI1/E6AKJa7/kXAnxkIP+FA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=kr0E2IPbo3+Z52vgzGFqQRfmeLIehprJaWTH/tm4YOs=;
	b=tzu2b98apEUYLeZv3TXeIglieBUlomy4DZ/wvKjKg7bkL72RJk8symaZpRosPOQT2Qkl
	 bPb6zk/qiHCTPusgo5x4N70jhj9NEXV7XfUAVTqTxHhNkUine0wQAsmLjpszggicAkzam
	 Me9es45Us4h+0tiyikPp9H888A1EOEwJxaKSEUMts3t1wicrpfz1IBDWwh0g7eODGi17a
	 5L7hu/tNEuuEdDzh0NGPetj6mVbnU8wp2/hvUT1q1HtpK7t7kU7whlomb/WefmbIQU0yF
	 nwsfhJ8SSNnVglT0JwFfHvaZwrtOIhonrdPSk1s6CU20PS/PdopI7zqCWaFM4R6DM1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NnkIAa1o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F2606A33E
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 15:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B11F2606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NnkIAa1o
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-38190551625so11740635eec.1
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 07:49:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795621764; cv=none;
        d=google.com; s=arc-20260327;
        b=Qmxj7dXydOov29oSXesS4BjeAmZ8Q/dMYjtchkIM9sQUQkN3NjnNhRAG6sAXEzlM/D
         raJ/J3m6tstRq2nTwy0W9mQVbfsp0Bql7MBYP7j+m3U0+E9ARFCuTFlDwhi0+A8qsYJh
         65bz2CNl4tfkQLxp0SgqR7iSfRO4AWjoTn9E7nONFrZ3rnr9bVgixPZUFijtrnmKra7u
         Jh88ahSA59+DZqAZ+GGsuWm89Q6PajoNoXdpGVHpBTzwaXKGHTh+sfn6h2h8cOGGn9RR
         5sWd5BpNwjQyhTd9o9xFbqb0mch7Pbz/mkhpBfjN8LrBGWK2StnTuqjJ5cFkcmmoswop
         NTpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kr0E2IPbo3+Z52vgzGFqQRfmeLIehprJaWTH/tm4YOs=;
        fh=STY0UwL4CfinZYcBYSb6efFSIGtJP0pSKb5NtthMHc8=;
        b=Q1ZrvKgcL437Opw734rMz33gbW5Xnaj13jnoK02Dnl4ylj0DXbJu2l6Dk63iRdyjtM
         hf3CTxBepK4Q0lEbFcWvYn9OBMWFsuwzO/bAAYSVZ1enUIRN5TP74QQ+h+AZclM/tf9U
         tYKUMj+/KEvX096M1YmyCV0VBN7f1oGCKEU86Nx8PcEfFKOEnXqQ3VVdQ0TEIOt0cbTI
         Bu3+9blt7DfbrMVmPAqQk9udDb/YWDlABQ1zm7JuVVJx5hDFIL/lRoB/O4vO66EPkhXr
         NNH7QXTqwZcW7cZLaUR+S58ab3H9K1+ZdQ11y1ee3rwsZRE4HEmsil7Js/7xUaDsgi+J
         k4mw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795621764; x=1796226564; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kr0E2IPbo3+Z52vgzGFqQRfmeLIehprJaWTH/tm4YOs=;
        b=NnkIAa1o9/zYaagApLkOGxNt+SouwzuTEUnsjzvlGV06sTdiQJ0+0q2V6REO1j74g3
         wfZ1f+O2UDOYf6U+L69NnlPiUAGnGRxWypgzqiAj+8Wfz8t/GZVDDiu/sD/hAiPTNttF
         lMgerOgBMPF4m4uNDxqCM86SCs0XbevLdR/TPqTanTvgBgmClKy6ASNhgLXs/Eg0Nhzz
         71cL2nIMu1SllUewWRtfYjxdIifZ5MO1sniCORASesyjv4NERxuUpd3WLs1zPP+4ZaEX
         3GFl9xcTT9b0gIpQq7SBNBNEn77IQ7HYcWhvSOwRycwP0x0a7gBXqBhgyczSP8Wh5PHf
         88RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795621764; x=1796226564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kr0E2IPbo3+Z52vgzGFqQRfmeLIehprJaWTH/tm4YOs=;
        b=CtI9Gwk7hLpjlvmkOcDdRWZTU9jzo1qfCslTpdKVxcG6S/QXsi5hWeh+GEpAg8/OAl
         cmDK38XxWles5C8xng2/qCY+PGMPSq9ezQGaL64MpUYbitApjvB7tL+XEQaCMvOVOuV0
         yp5dg0bQWb5FTb3HQQKxwDln0nlW8ZW3MEngedz+h7mMQR4P8SL2HwBRkdSaj8qzSnvy
         W17U1jwHPYacVrZIFXnescQEZCr5Kfov6YELU4g+cKxpjZweTQ9G0RHzmO3FSsnhDvV7
         NG9k8ezmTd6IbOsZgcuXlU3K4nk2ZX/rnSvRy1n2mTCQZJl1ROiV/JVZDWH/5Rt7k2Cw
         NiQA==
X-Gm-Message-State: APuU4Z/c4sc0a2ACwux0eYzVj/xKXDxKp+DPAD+ULMV365Pcg7e05f5Y
	TmlGz+RzcV0wARwgCcsSEx1OEUzyc2bZuVWVKeYGhBGvVXkBOtLxcS1EA9l1OfNBk5aJkKipbeS
	26/YjyKmmw624Hy0MSo7qozqB0lCXWGk=
X-Gm-Gg: AZFdTZds3/GIASqvv8oMFgZay1736I9ekj+sI7oQ9qVG1EqdPnLn+9wXOdvrW0Kf747
	1NY92D3HzfkK+jcOzHsfQBXl63QNgkJuiv78YBMHC8OGKroI40crMkSal8pLVKd4uarSvjX2Z5S
	V4rfFIIeXRm4fm/Mvl1JxnigPCSwZZrSAge8Bz+1XujS+AtmPbLwMxSGriX2J/I5ePoc5PpwiwJ
	//+baTYBv0mwfagO8QpdvCRpjc06Qq6Xgko030AzWUXuN+tRaJeZizpwGRxo/fSDDEso8KR9tyX
	d11C/bN4e5Zz8nbnL0MV5A1v59+MnKwFwzoOwQKNL6HWfJyDTC4TXYIaY2MFPedDcfG1EqNXeE4
	PajQNaaAaFPkFNNiTROgHl1csZp3OYgHdhCF/
X-Received: by 2002:a05:693c:8209:b0:383:e7af:c28d with SMTP id
 5a478bee46e88-3856f14d5b2mr18886039eec.9.1795621763371; Wed, 25 Nov 2026
 07:49:23 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <CAGvcwsDdKSZe0reeuT0eQabaSbM6+KAfwFimxiqhvKrjD2nQeg@mail.gmail.com>
 <awX_cNOqtTjAP33a@ryzen> <CAGvcwsDwi9vNcCLxdBz-Arx=5i-fFvqxP+QbRKrx7hK4yqmvRg@mail.gmail.com>
 <awa_ys0XSt9UwAZE@ryzen> <CAGvcwsCvuedSN4Fs1TaFRTVc2QbcQK94P6+xqH3qmEvNqq3d9g@mail.gmail.com>
In-Reply-To: <CAGvcwsCvuedSN4Fs1TaFRTVc2QbcQK94P6+xqH3qmEvNqq3d9g@mail.gmail.com>
From: Pe3k <pe3cek@gmail.com>
Date: Wed, 25 Nov 2026 16:49:10 +0100
X-Gm-Features: Aa3M54re8Ic4_ndXbRCPVeO2fo44dNsRCNSsdqfZpXbOFg13fIKcZDy5WBGGdQA
Message-ID: <CAGvcwsDzu1HEUPWNRvybqH1=Lte0rYk9JohctDgR252eByBtvg@mail.gmail.com>
Subject: Re: iommu/vt-d: data corruption, AHCI gets IOVAs inside its RMRR (HP Gen8)
To: Niklas Cassel <cassel@kernel.org>
Cc: iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I tested the suspected commit and its parent on the spare Gen8. Same
setup as before: intel_iommu=3Don, translated default domain, the same
copy load, and the 5.11 mainline config trimmed with localmodconfig.

  c062db039f40 (parent), two boots: clean. 0 of 6 copies bad, no DMAR
      errors, and no map in the RMRR range in the iommu:map and
      intel_iommu:map_sg traces.
  c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu
      ops"), one boot: broken. 21 x "DMA PTE for vPFN 0xf1f80..
      already set" with the WARN in __domain_mapping, 1 of 6 copies bad
      (20 zero pages and 1 page of RMRR firmware data), and iommu:map
      shows AHCI mappings inside 0xf1f7e000-0xf1f94fff.

So c588072bba6b introduced it. Its changelog says "Remove the iova
handling and reserve region code from the intel iommu driver". Before
it, VT-d reserved the RMRRs in each domain's IOVA space itself. Since
then that seems to rely on the generic reserved-region code, and on this
machine AHCI's RMRR does not end up reserved in the IOVA space of the
group it shares with 00:1f.0.

Thanks,
Peter

On Wed, Nov 25, 2026 at 2:48=E2=80=AFPM Pe3k <pe3cek@gmail.com> wrote:
>
> Hi Niklas,
>
> Yes, 5.10 works.
>
> I picked 5.10 because it is the last release before VT-d moved its DMA
> API to dma-iommu (in 5.11). Until then the VT-d driver reserved the RMRRs
> in each domain's IOVA space itself. Since then the IOVA allocator, which
> is the part that hands AHCI addresses inside its RMRR, has been generic
> code. So 5.10 was the obvious first candidate for a good kernel.
>
> I tested the mainline 5.10 and 5.11 builds on the spare Gen8 with
> intel_iommu=3Don, translated default domain, and the same load:
>
>   5.10.0: clean. 0 of 6 copies bad, no DMAR errors, and an
>           intel_iommu:map_sg trace filtered to the RMRR caught nothing.
>   5.11.0: broken, same as 6.12. 23 x "DMA PTE for vPFN 0xf1f80..0xf1f94
>           already set" (with the WARN in __domain_mapping), 2 of 6 copies
>           bad with zeros and RMRR firmware data, and iommu:map shows
>           iova=3D0xf1f80000 from iommu_dma_map_sg <=3D ata_qc_issue.
>
> So it is a regression between 5.10 and 5.11. The likely commit is
> c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu ops").
> After it, the domain's reserved IOVAs seem to come only from the device
> that sets up the domain (00:1f.0 here, which has no RMRR), so 00:1f.2's
> RMRR is never reserved. I have not bisected inside 5.10..5.11, but I can
> if it helps.
>
> Thanks,
> Peter
>
> On Wed, Nov 25, 2026 at 12:00=E2=80=AFPM Niklas Cassel <cassel@kernel.org=
> wrote:
> >
> > On Wed, Nov 25, 2026 at 11:01:17AM +0100, Pe3k wrote:
> > > bugzilla 221713 looks like the same bug. The ML10 v2 in comment 15 sh=
ows
> > > "DMA PTE for vPFN 0xf1f81 already set (to f1f81003 ...)", which is in=
side
> > > the same HP RMRR (0xf1f7e000-0xf1f94fff) that I see on 6.12, and its =
7.x
> > > symptom is the same "Emask 0x40 (internal error)". Their bisect of th=
e 7.x
> > > symptom points to d373449d8e97 ("iommu/vt-d: Use the generic iommu pa=
ge
> > > table"), but the RMRR overlap is there long before that (they saw the
> > > PTE error back to 6.0, and I see it on 6.12). So my guess is that
> > > d373449d8e97 only changed how the overlap shows up.
> > >
> > > The H97 thread looks different to me. There the faults are "non-zero
> > > reserved fields in PTE" at 0xff4xxxxx, outside any RMRR, and they dep=
end
> > > on the request size.
> > >
> > > sp_off: on this machine the only DRHD reports no superpage support
> > > (cap c9008020660262, SLLPS =3D 0), so I would not expect it to change
> > > anything. I tested it anyway:
> > >
> > > 7.3.4 with intel_iommu=3Don,sp_off: no change. It still has 0 DMAR er=
rors
> > > and 221 failed commands with "Emask 0x40 (internal error)" (121 READ
> > > FPDMA QUEUED, 100 WRITE FPDMA QUEUED). 3 of 6 copies lost 8 MiB each
> > > (zeros), and the iommu:map trace again shows 21 maps with
> > > iova=3D0xf1f7e000 size=3D0 from iommu_dma_map_sg.
> >
> > You mentioned that 6.12.118, 7.3.4 and 7.4-rc4 is all bad.
> > Is there any kernel version where you did not need iommu=3Dpt for a rel=
iable
> > system without corruption?
> >
> > This seems like either an Intel IOMMU bug or a HP ProLiant MicroServer =
Gen8
> > specific bug to me. Hopefully someone more knowledgeable in those areas=
 will
> > chime in.
> >
> >
> > Kind regards,
> > Niklas
>
>
>
> --



--
