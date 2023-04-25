Received: from sonic303-19.consmr.mail.ir2.yahoo.com (sonic303-19.consmr.mail.ir2.yahoo.com [77.238.178.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B8A7B
	for <iommu@lists.linux.dev>; Tue, 25 Apr 2023 04:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s2048; t=1682396274; bh=SiR9M7sSXt3n8xc1z4h4M5DhIANB7FN4UvbAdNgD5Z0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=C6S0UPJME89uQ4UyhatdE5STqxvpkQ14bSQVbdvq/9oVTnBg8StzdaaPWcaTMkOcGncUaTVwpa7SSv+gBRS5yAUqM1g/GzsVnqZVTB2Ru/ijD381I4DqAFJ147z+Ozz3m4AnG8KNY9bGvAqJGKDR+uN3QTKlYfEEYj2clSdKu8uybdIqUydmjXiMoQsGcp6UlIWvMyUrMpUC4w/rf88jgxBgaCyriGH5Oz3HvbsNiW9b6HnyonR1FmuwKP8lqirnM5byYtIWSWBn/zPti2N1rkUrlzMkPvpIUY6LTeCOBCChn6QsrmQS2vJl7TvTI3DxqzqhChz+U6yq9VwPUzukMw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682396274; bh=Cz+7G70yiAS70EDqvPRgAcKHIDSOZKq9WkndlO7SiiD=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=bcJIZA5KAUxkQTWgQZJeV/2QeekEq54/XS51H7UDvYRDnsvSUU8MGi3HrSxXBFGGaW5aLbgIwuFEOnVzYM486epjJxz0yPjNhTyHTD136dn5ZMcwtd6a8aCpeaHXFXeDCM5CBNVyo98QZmwYYz7+YcDDNHSwGBviD4veQRK2DeC5EVkImo3NH5Ncb24Koaah1WTk1IIVLWHDpVQa9eqnoAsHqE8mU1CMxijqlgrIO0t36CbAB8r9bqBON/GWrgCPwZTnagpnfEfFAlFYbptM9zEfDVnEyCHDjVnsLmDTwQTqqClG3tR3EwhGIqh+FR1LWMPC/OqFKRLEpEtdq+hhWg==
X-YMail-OSG: I0OILuUVM1lrXG0wpp9N64ebZ6N3DRvQUu0HEsVE5Q_pEq.UnehFslC3bVuYrP7
 hXjtuwJogPhCQL_HSG0koEUyTVKDUE8gdvTgANctzn7sgsVMMH5B9oLyXgSVFgNNw5JFcTouJp4E
 8mR1LdJqFgUr1qmAisChiETtztxveJ7eOFSh0fzqphKzTtyxetzMruMX1uCnzZYMgjTIohFG5SoC
 Az2my6Amx94rG74UwphSmUgLouSM0kij5zJnkdFpO0hk6ZPsAyWhNFjMWJWgLm5vYX5zwKqyCcfD
 X9Vf_BYmdo77OfDDJFFUDVQAvwQb80MltFJYHtTHQwqKQcxtoxahQdRHVM2JiUse5b2Ll_mGozEb
 IUmlXl5Pro33Zh760DEMGg8xSV7v6MxWU2d0OjU_.z_3hmOAIzc5HnGoaHpT01hSvM3bU3I0gyVd
 jNzU62Nw10myD6Mwnsr.xr_n8YvJDAdwCpo91tFST0.m25_YXQKfHuZiMzLr_RrqYG6tnO8Coqs5
 a3AJikgE34HB67JCebNe5C4z44dKEzFDYDZKXAA8ICxmmBtU7LrB65LxDHjmQ0Nr4OB9nVAsnuBB
 3e6muyx_F2sS8EK3fSAHsTYjxdRCWTm3UpOMLItqAnfJKGqcqCJEooDUmGXyTZ8NdXW7g1IcT0Qo
 _yxUxzb7lx5O8AKGqX_klgK.7hFRzMejE0peqJSkVJ_8ZflKhuhVPwxJPqbv6MfTkUDbNd7bi2Pb
 7.eLDYSEKmqWpMXUWvG52Pyvuch4TXeBMRIVBSKoJ3vIzlQcNw5mRGeiIiQMfeQKeDf.oyX9xy2t
 y_vbSgQOnFxeH94GbtAWx2l1u85KAMKX8aVXvqrCMkR7sboYU1Fydrg7ElhIL9v2ZDe6Mp6Kedh3
 jmAbssSyeZVEVC3n2dqFYPZbFvbLdX2dPpq4ASJE69MKxHjR0B.7.0s6wyEAaP5sufgDPMjQbqGw
 a8UuIZ0nmDohVHw4TgD9CfvH5c26EpshHOqj7F0eMBVdC07JRXIVZfRnKXEH1h6DZtaphp6vzYPL
 FJsMWczlCbhcFTUQ6s8FlEBHzmpQxwqA4EnR3_PCjUfGpuvVV_yphZuM_N5hutWOuOG23W6IKRXP
 s2NgvLsUgxHyjCzDHCSy_GbxfQhWHCW0xGhhgml4YpMrWu2cBI7d90ecPCSyEOURY25_HQnvC_a6
 AQGXPqcY2jOZmskh7jAwgW3hBi..78wO83p01x5GFfSFd59t2M_dARDfxzRy9coRvliRZxyCYe0V
 B.RlyDkNcVlwKt6Wr5ofrDl5pOZg0oFWkFCzjgTSyHhKLH4CHrbKYVqPJQt4bMELkPuHi8RNQZZI
 I1pVSucB2K7244MUzFPaE_psQXITy7wdtTHjOzjvLb4yUMt9jEDJtRxvQBnlyXsSQDYjigt2HUOJ
 aHHKqfLxBCx5q67dosJ4qzNrNWPjD0KriRmPe..5reeK.tXD0KG5zbECQTXBw2HPdcvyvK5wtek2
 57wFtZtdN7uGX2Lz8vf0pmDUIdqWc7zX1KMYiEpUDLPupPXscYYKKDzU4rhasciLgKNPrlAEt5eb
 g5Guya1.DBUkjGbapIbh35JoBqPT4WziMJqdLzaexutabZgYtgW51WSAPNUCLTC.zTVwQxSgux2L
 eskk4Nfr.DnO..uJSseql0c7be62psnyGniiFZM9Gcr_LynxmymSQeFta452KvIfcKqyfRAjlgrx
 10_kCjGdaAd69jNs1iDi7DeMzVeFq5umnGCbgKgT3Tl6_AVelzqzGuPAuE1AQbgNTkuDnCgZEW0M
 Ifd2.fuILBXnuPH2PMT._R.R2MAbtHXapQPZyVwe054s.tiRfUDiZbBFhyNqWdgL7byRPnmCkGVY
 MuKmOfhbqdG7a4m4rDRX3QebwocobdKNA6rGEmIRGq0PBOhY_oehaPkQ4cjgwkoxQYJNWs.4h5do
 WqHJVpdV8PW8RnnTXh7OMzqriBtKZYs2R8lSxWJJ_aRqSTkcTcb2JRY8ZKNwTy0dvZxsup.z7Gqz
 NdoFQEN.EtM6InhPBtLXSoIkJkNrdr9M54naj4Uc9qY0MNZg6HEFDV25wivYb3gF2Vc5H5r_FMtb
 sgM6hgf97hp4fooDE5C.bfY0.kQH901vrvB3E0Kv21xIUCbi2Wsf4jLlKqGy5gLQW9QmXHyRbMPI
 MMgJs96aRlPmTX3fZZc_s7P9y.tvqiMADpIcMMsiMv7PxMyzQc7NXvzFHGr82da2cXp2r73Bz5U6
 83_n.lIAkoqS.Y4v5YCgyNs5H2oXXOvAiRQXcXEJoVELYUoRsSbqWgNQ.CVOKIyXrZcVxVU9g51w
 9nQAvg4OjInhcf.8H1yk9
X-Sonic-MF: <jason_a69@yahoo.co.uk>
X-Sonic-ID: 056af421-83d2-420d-a1c6-79c8c0c4b96d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Tue, 25 Apr 2023 04:17:54 +0000
Received: by hermes--production-sg3-6d6fb994f6-q52kb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 663c94064a0a1ef0f94048cbb73dd6db;
          Tue, 25 Apr 2023 04:17:47 +0000 (UTC)
Message-ID: <9648f668-a3bc-3296-71d1-c91cd4c9980e@yahoo.co.uk>
Date: Tue, 25 Apr 2023 12:17:39 +0800
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
Content-Language: en-GB
From: Jason Adriaanse <jason_a69@yahoo.co.uk>
In-Reply-To: <07ee0cf7-a5c2-f87a-d627-8dd8fb082345@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Ok great,

I take it a change needs to be made in
drivers/pci/quirks.c
?
I do not mind making the change locally here and letting you know if it 
works or not.

On 24/04/2023 22:07, Robin Murphy wrote:
> On 2023-04-24 14:44, Jason Adriaanse wrote:
>> I took out "iommu=soft" and the server failed to boot, so yes it does 
>> break.
>>
>> The first error was
>> ata7.00: Failed to IDENTIFY (INIT_DEV_PARAMS failed , err_mask=0x80)
>
> OK, great, that confirms the underlying issue existed all along, so 
> the regression is only a change in who wins a fight between certain 
> conflicting command-line arguments, which is arguably not so critical.
>
> The rest of the evidence points to 88SE9235 wanting the same phantom 
> function quirk as most other Marvell controllers, since although it's 
> apparently been half-fixed such that DMA for two of the ports is being 
> correctly emitted from function 0 - given that you say two of the 
> disks *are* detected OK - the other two are still claiming to be 
> function 1 after all.
>
> Thanks,
> Robin.
>
>> On 24/04/2023 21:20, Robin Murphy wrote:
>>> On 2023-04-22 07:25, Jason Adriaanse wrote:
>>>> Hi Christoph,
>>>>
>>>> Sorry for my late reply, I have been on the road.
>>>>
>>>> So, if I boot with
>>>> intel_iommu=off
>>>> Then the server boots fine..although that is not a solution because 
>>>> I need Intel iommu for virtualisation.
>>>>
>>>> Also, I build all my kernels with CONFIG_INTEL_IOMMU=y
>>>>
>>>
>>> If you boot 5.15 *without* the "iommu=soft" argument, just 
>>> "intel_iommu=on", does that also break?
>>>
>>> Robin.
