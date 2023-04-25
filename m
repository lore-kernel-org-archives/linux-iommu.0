Received: from sonic312-25.consmr.mail.ir2.yahoo.com (sonic312-25.consmr.mail.ir2.yahoo.com [77.238.178.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE437B
	for <iommu@lists.linux.dev>; Tue, 25 Apr 2023 13:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s2048; t=1682431117; bh=JfN1smeY4l2RyuTBfLjf4IWhEfpPgXo9FmIN0TnkTTY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=kidKnVnpTEDLJfGaAJSqRU9AxacbDjXHOzI219kBR5ppcwagY8ABP9aF0aL0NUXIsBvRDl0J2b2hEc1OKGAnY3RJvNsqJ9s48R5MQRE7aPrdenRb0DReerQK9Hv9Yeq7ARbiwjVQ/RwzE4MuMFTCd28SFoKLnXNLznmpaq2YwU3ni8p++mOkukY6zf7Apv1c+qvvGg81ItRZXHFdEzRTrMraqmn1EnN30eXDVraKjhMy0dVaPF6x88Q3jYVtmVqWjYUYpX2kiM5dP79SN1PLtmfuIh5jTz/AhV8QCyL69fMUJdaS+fbArp0y2EoLD4keruLX0Y7qyG6mSWRzQ/I6Wg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682431117; bh=YWzgvsvoWt07w7AJGM8kCeRoALwiYxqk1htuKDfd3zg=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=c96boJANd9RvIlRSIu0iD3IPClh1s/gIbM3tU4cyqmE/TlLlHvu8NLwjueeUvhWBdxLV0PyfmL3w/kQ9Yi/ncsioa1uie7y6812Khyw3570484zKPtAQ7LEBu+bYPJ4XoqGG/BcW+h67BG+fsIaIAwRlxsV3p6/vbJsfCPRKtJtEzEsfp3DJv1uMerYUpYRyPmkcM2brANJu4FSAkw+StMBEGjGfWjXTRfnJllYiORcd72dGy2h+HQxGv8bLi3TPWmqvL13TZBO6aSgw4lF1Vkqz7G+RiDKOz7WWb/ji2JRCDiY9Hxmcv8/nW9yeDnVQKVxEEVOmYhtYDMagh66LsA==
X-YMail-OSG: mkHLar4VM1n1qBHfIU5lYHSS2xjeYmxkropmNKvClEIbDNj9AP7kClitDqGypgl
 gHkffRq_E2DXdxMWosYsucwLYiHOhm19l_mT3dTmYpKEhfNexu.WMVOWSyUvW7YwDq6AazN2iFm9
 _snxADxc_riHZLZFR5ET_OWMyG9Ph8LYA0903s2TYnW9PqU1dplqrNTtNB8zEBUfZYvI_8.op4hd
 Fr55kmfZ7OrAJDKiF6LyLoVraQI6Tvm2GAkL3ZqlgnPIsXQ.Bitzyg5.OMFbD4ueNV.1SXKIy.JQ
 BaYs3jY3ygppidp7NyEAxx.foQJodV67Y.iTJil.xj5yZyME2RWhNoc8n1KnlffbSCQvGIFMiwtj
 He_vw8cClLrtfc132UnWh9pUJp_aewvu5iR0OwTzKY39R.MNCXRl7qAxZ7Wc7HjnS8yYk_kNsFER
 KJJ.6.OZZ4hGiTGvJqLtvwNIQ.c2tW6ZkBwih3b6Pk3lhIJYgiUAF97BR5yM9iTTsSaiAOk7iwKX
 dvklBqQROQYLhrZl3BV40ZIyqi69V.8bxyt3mS.BtXgKCdJtQcc8z0J_fgXpQK5K_ra6uqPzQdz0
 K0g1jScg6cFCYMbV3ly46jhkhqDczUKLJjWhbrTelFrt3LetYZws20Z4FGRYyBQ9t0Q.ucGWp7iX
 b7PPzaBFFBtIgd41WiKpZfOGSWSZeEQSk14GXF9zO_iDu8wyoxNiMwHdl0dxeQ6raCT0Ey0ldLXq
 3t.oSFdi8olLU2sMGcbSZD2HMtzmmDXeh7HeswkIc6hZ8ykcGuUhQOQPrBpvGedRvPG722Tbwiy_
 tlugAIP7tNhBCQne7E8mVrnNT3nSSG9HhUT3HF7a5XVbH0G_fpEpVKmysWJRyAQdqDEsPLGzjvLD
 VvXiHTlcEPwlIq3PSKq4d.EPWK.Xv4EscnbPKccVjmSa1YoCJh49Pu5b9uMGoxK47WzRN7_uoUIT
 RBUQbQZjxOsu9EtUhvOqXAtlqfE5SHf35GZPZQWf_Oje3UJ1UvG0S5sfDeYSGhfrKZoKGCAt5ppT
 gw2zUOoavFm.QGi3E6arTM_I9VmdhSngIWs7SQn6X8CfyrZHyNu89CJwN8uW5gsSLa23TAyfzJv1
 cGqel21iKntGqJOTv5mCScGnCd.Sd4l2bs8N0hC0Jad9rUnRSO6ujyuNAUrxWhM_pNGAKC.qmBBD
 ujiGWtc._WpPt2Ku7jgH6xfAyAHd24f1ZHnJsevzdmK1sJSQE4WBXW3HIxNTLkdJ9uzPtLJ3thJb
 Ao.chDY1VUz58oALQwwTur73JTUPcivNA6xEWhStE3.pG0xWHD3ZFwtyJG72G4VlpVBQUpFQXIK2
 TNk5MapTR4v.BRIu29yONtw8YSd4a84wYBkNUU9S9bXFpDZX5BQMk3B4J7bzwjVkM1DOIM9mYTK6
 l14wFe9tv81HA_C.STWowvgFw8i.cBAQQapxTK99BgKn2JONqVBModkABzTu3iKnZTFkhNOAUZVO
 YexPruLlmFzwadXQX4MatCyvufqUvVG_sUns1.p4vVP6qIYfugVELfL2nInr_vATyoFtlQwWGYVm
 zXLZl8wS04hJVVavt_JkM_qzpuhY0AydHJncbKOr0Gh1fZ465exHGDcE4qYQLfesRyOiDKwsgZyQ
 8wH5GYU64cn3CvQN16AT8.sGBMWmI6BCQjP8tJ7Dxwzowk.DSQ6M_B0R2I9OaktgHSSirwZULJTN
 u4IxCFBRtHsNKeF_q21cSuj7bSc.2C0NxVW6L9K6i.vcEi5TwLYVos3PyAHsADpAsQqxV6XlBw3r
 IVdrCt1UGS0ZeUo.qtLqh0v0OfkjNRSy9RkFiqOsYh2jEW5mFKOOvLQTRwtiC0rfq6cER.1kztIR
 X21oTpxyoZnWQWn55uKFdZUL5XjzwfoQgZNNrz4UN7agoUpvH7_gDVN8a1nve9i4veyvQ8DA3yzv
 8Zl5XcayRJlb1Ab3M0w5mbEIYnQjMhFLcnTB8HNBfxs9aQZzgjwEoh.uiy0DFoK1AsG_KxOgzb7c
 k7aldqgg3skyuIIDFBS7EKnRedw73uep_56_ZQeeDe4VGRPG.ijLrrFUAExaantOQIWeZknOSB_y
 wrRuSleISIzzQgUqBe2MP3YDQkOJcZaRfbFybBCI9LN34CcDcrxckeClZbDpIqrJtZHw5WLaDKLL
 oVqYO3mwUXauEx8.mzHd9V.nBN32zwGL8y4ZNBzVwKhS2a0fTHi1MYdLw_VnXJV4XOqOvs3JXfYK
 .5knFk.XpqHqeTP.x59N1JbDsYdkrXF7JHgj9Jsu9V1sPQ3X8KoDS6tVSOwe_LzPErO_chsNPmsM
 ArEdZWtNTqf95krpamPVMfQ--
X-Sonic-MF: <jason_a69@yahoo.co.uk>
X-Sonic-ID: 7c50950a-17eb-438d-b90e-53851acd525d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Tue, 25 Apr 2023 13:58:37 +0000
Received: by hermes--production-sg3-6d6fb994f6-gm72r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 71b4c9f1024ef49eafc09f6329ff8c1a;
          Tue, 25 Apr 2023 13:58:30 +0000 (UTC)
Message-ID: <14f2b1ab-2c7c-fa4d-5854-3df08ac9feef@yahoo.co.uk>
Date: Tue, 25 Apr 2023 21:58:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
To: Robin Murphy <robin.murphy@arm.com>, hch@lst.de
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev
References: <20230416065503.GB6410@lst.de>
 <fc9f4cef-9426-c9d2-3c2c-3ce12fe5f6c3@yahoo.co.uk>
 <5f37b0b0-6cb5-b210-a894-d1e91976126e@arm.com>
 <2a699a99-545c-1324-e052-7d2f41fed1ae@yahoo.co.uk>
 <07ee0cf7-a5c2-f87a-d627-8dd8fb082345@arm.com>
 <9648f668-a3bc-3296-71d1-c91cd4c9980e@yahoo.co.uk>
 <1539e760-392f-a33e-436e-bbf043e79bfc@arm.com>
Content-Language: en-GB
From: Jason Adriaanse <jason_a69@yahoo.co.uk>
In-Reply-To: <1539e760-392f-a33e-436e-bbf043e79bfc@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

I am happy to report that the change worked, this is what 
drivers/pci/quirks.c looks like

/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c49 */
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
                          quirk_dma_func1_alias);
/* https://bugzilla.kernel.org/show_bug.cgi?id=217218 */
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9235,
                          quirk_dma_func1_alias);
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
                          quirk_dma_func1_alias);

Relevant output of dmesg -T with the new kernel running

Tue Apr 25 21:45:13 2023] scsi host0: ahci
[Tue Apr 25 21:45:13 2023] scsi host1: ahci
[Tue Apr 25 21:45:13 2023] scsi host2: ahci
[Tue Apr 25 21:45:13 2023] scsi host3: ahci
[Tue Apr 25 21:45:13 2023] ata1: SATA max UDMA/133 abar m2048@0xf7d06000 
port 0xf7d06100 irq 40
[Tue Apr 25 21:45:13 2023] ata2: SATA max UDMA/133 abar m2048@0xf7d06000 
port 0xf7d06180 irq 40
[Tue Apr 25 21:45:13 2023] ata3: DUMMY
[Tue Apr 25 21:45:13 2023] ata4: DUMMY
[Tue Apr 25 21:45:13 2023] igb 0000:05:00.0 enp5s0: renamed from eth0
[Tue Apr 25 21:45:13 2023] ahci 0000:07:00.0: AHCI 0001.0000 32 slots 4 
ports 6 Gbps 0xf impl SATA mode
[Tue Apr 25 21:45:13 2023] ahci 0000:07:00.0: flags: 64bit ncq sntf led 
only pmp fbs pio slum part sxs
[Tue Apr 25 21:45:13 2023] scsi host4: ahci
[Tue Apr 25 21:45:13 2023] scsi host5: ahci
[Tue Apr 25 21:45:13 2023] scsi host6: ahci
[Tue Apr 25 21:45:13 2023] scsi host7: ahci
[Tue Apr 25 21:45:13 2023] ata5: SATA max UDMA/133 abar m2048@0xf7b10000 
port 0xf7b10100 irq 41
[Tue Apr 25 21:45:13 2023] ata6: SATA max UDMA/133 abar m2048@0xf7b10000 
port 0xf7b10180 irq 41
[Tue Apr 25 21:45:13 2023] ata7: SATA max UDMA/133 abar m2048@0xf7b10000 
port 0xf7b10200 irq 41
[Tue Apr 25 21:45:13 2023] ata8: SATA max UDMA/133 abar m2048@0xf7b10000 
port 0xf7b10280 irq 41
[Tue Apr 25 21:45:13 2023] usb 1-1: new high-speed USB device number 2 
using ehci-pci
[Tue Apr 25 21:45:14 2023] usb 3-1: new high-speed USB device number 2 
using ehci-pci
[Tue Apr 25 21:45:14 2023] ata8: SATA link up 6.0 Gbps (SStatus 133 
SControl 300)
[Tue Apr 25 21:45:14 2023] ata6: SATA link up 6.0 Gbps (SStatus 133 
SControl 300)
[Tue Apr 25 21:45:14 2023] ata7: SATA link up 6.0 Gbps (SStatus 133 
SControl 300)
[Tue Apr 25 21:45:14 2023] ata5: SATA link up 6.0 Gbps (SStatus 133 
SControl 300)
[Tue Apr 25 21:45:14 2023] ata7.00: ATA-9: WDC WD40EFRX-68WT0N0, 
80.00A80, max UDMA/133
[Tue Apr 25 21:45:14 2023] ata6.00: ATA-9: WDC WD40EFRX-68WT0N0, 
80.00A80, max UDMA/133
[Tue Apr 25 21:45:14 2023] ata8.00: ATA-9: WDC WD40EFRX-68WT0N0, 
80.00A80, max UDMA/133
[Tue Apr 25 21:45:14 2023] ata5.00: ATA-10: CT2000BX500SSD1, M6CR030, 
max UDMA/133
[Tue Apr 25 21:45:14 2023] ata6.00: 7814037168 sectors, multi 0: LBA48 
NCQ (depth 32), AA
[Tue Apr 25 21:45:14 2023] ata7.00: 7814037168 sectors, multi 0: LBA48 
NCQ (depth 32), AA
[Tue Apr 25 21:45:14 2023] ata8.00: 7814037168 sectors, multi 0: LBA48 
NCQ (depth 32), AA
[Tue Apr 25 21:45:14 2023] ata5.00: 3907029168 sectors, multi 1: LBA48 
NCQ (depth 32), AA
[Tue Apr 25 21:45:14 2023] ata6.00: configured for UDMA/133
[Tue Apr 25 21:45:14 2023] ata7.00: configured for UDMA/133
[Tue Apr 25 21:45:14 2023] ata8.00: configured for UDMA/133
[Tue Apr 25 21:45:14 2023] ata1: SATA link down (SStatus 0 SControl 300)
[Tue Apr 25 21:45:14 2023] ata5.00: Features: Dev-Sleep
[Tue Apr 25 21:45:14 2023] ata5.00: configured for UDMA/133
[Tue Apr 25 21:45:14 2023] usb 1-1: New USB device found, idVendor=8087, 
idProduct=0024, bcdDevice= 0.00
[Tue Apr 25 21:45:14 2023] usb 1-1: New USB device strings: Mfr=0, 
Product=0, SerialNumber=0
[Tue Apr 25 21:45:14 2023] hub 1-1:1.0: USB hub found
[Tue Apr 25 21:45:14 2023] hub 1-1:1.0: 4 ports detected
[Tue Apr 25 21:45:14 2023] usb 3-1: New USB device found, idVendor=8087, 
idProduct=0024, bcdDevice= 0.00
[Tue Apr 25 21:45:14 2023] usb 3-1: New USB device strings: Mfr=0, 
Product=0, SerialNumber=0
[Tue Apr 25 21:45:14 2023] hub 3-1:1.0: USB hub found
[Tue Apr 25 21:45:14 2023] hub 3-1:1.0: 6 ports detected
[Tue Apr 25 21:45:14 2023] ata2: SATA link down (SStatus 0 SControl 300)
[Tue Apr 25 21:45:14 2023] scsi 4:0:0:0: Direct-Access ATA      
CT2000BX500SSD1  030  PQ: 0 ANSI: 5
[Tue Apr 25 21:45:14 2023] scsi 5:0:0:0: Direct-Access ATA      WDC 
WD40EFRX-68W 0A80 PQ: 0 ANSI: 5
[Tue Apr 25 21:45:14 2023] scsi 6:0:0:0: Direct-Access ATA      WDC 
WD40EFRX-68W 0A80 PQ: 0 ANSI: 5
[Tue Apr 25 21:45:14 2023] scsi 7:0:0:0: Direct-Access ATA      WDC 
WD40EFRX-68W 0A80 PQ: 0 ANSI: 5

Thanks everyone for all your help.

Jason


On 25/04/2023 19:37, Robin Murphy wrote:
> On 2023-04-25 05:17, Jason Adriaanse wrote:
>> Ok great,
>>
>> I take it a change needs to be made in
>> drivers/pci/quirks.c
>> ?
>> I do not mind making the change locally here and letting you know if 
>> it works or not.
>
> Indeed, something like this (make sure the IDs actually match what your
> device reports, I'm just guessing):
>
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44cab813bf95..a9166e886b75 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4161,6 +4161,8 @@ 
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9220,
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c49 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
>               quirk_dma_func1_alias);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9235,
> +             quirk_dma_func1_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
>               quirk_dma_func1_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0645,
>
>
> Marvell themselves seem to lump the 88SE92xx products together as a
> closely-related family, so given that we do have quirks for 3 of the 4
> already, this one does rather seem conspicuous by its absence...
>
> Thanks,
> Robin.
>
>> On 24/04/2023 22:07, Robin Murphy wrote:
>>> On 2023-04-24 14:44, Jason Adriaanse wrote:
>>>> I took out "iommu=soft" and the server failed to boot, so yes it 
>>>> does break.
>>>>
>>>> The first error was
>>>> ata7.00: Failed to IDENTIFY (INIT_DEV_PARAMS failed , err_mask=0x80)
>>>
>>> OK, great, that confirms the underlying issue existed all along, so 
>>> the regression is only a change in who wins a fight between certain 
>>> conflicting command-line arguments, which is arguably not so critical.
>>>
>>> The rest of the evidence points to 88SE9235 wanting the same phantom 
>>> function quirk as most other Marvell controllers, since although 
>>> it's apparently been half-fixed such that DMA for two of the ports 
>>> is being correctly emitted from function 0 - given that you say two 
>>> of the disks *are* detected OK - the other two are still claiming to 
>>> be function 1 after all.
>>>
>>> Thanks,
>>> Robin.
>>>
>>>> On 24/04/2023 21:20, Robin Murphy wrote:
>>>>> On 2023-04-22 07:25, Jason Adriaanse wrote:
>>>>>> Hi Christoph,
>>>>>>
>>>>>> Sorry for my late reply, I have been on the road.
>>>>>>
>>>>>> So, if I boot with
>>>>>> intel_iommu=off
>>>>>> Then the server boots fine..although that is not a solution 
>>>>>> because I need Intel iommu for virtualisation.
>>>>>>
>>>>>> Also, I build all my kernels with CONFIG_INTEL_IOMMU=y
>>>>>>
>>>>>
>>>>> If you boot 5.15 *without* the "iommu=soft" argument, just 
>>>>> "intel_iommu=on", does that also break?
>>>>>
>>>>> Robin.
