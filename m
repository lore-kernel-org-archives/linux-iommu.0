Received: from sonic310-57.consmr.mail.ir2.yahoo.com (sonic310-57.consmr.mail.ir2.yahoo.com [77.238.177.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902052108
	for <iommu@lists.linux.dev>; Mon, 24 Apr 2023 13:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s2048; t=1682343906; bh=ijG1BgFQ3hk9R1P0TkyZEKXHIErIwL9d09lckQ/m1F4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=kxG7ul7KcDmjuRCSXJ10P9M+SNvkBwD2v2oho3ZWEiwUe5XvIog4bSJpUgMu/pYevMhlgTWsUKzaPPALJsV7XhrjheZo1FRO+qdiVWTPqt5P5MYEnMDgHvbwj38KNZJj70tuyUyCGgaYjX8ixxNntJE3HCbI6dvYsqCvkZKCEQ5kbICXEkcp9z4NwJXOKMbYbJdDI44Iz3Eqz7BP2IsKsA62gN0Zf1EKDhBShKORAfZ+EXNSwKIGrNnXMt/Me7Xc0WCi8gK8MjV/7FKFCHD3QeJ/JXjOTNu+gFnNyMvpZhMCTrk3S6hCYi7ZmkYDvix7+qdG5o2JyaimBbdJfwHahA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682343906; bh=5JMXP/gcrqqQKejCWab/oRgUkq1HAUpFu4BTZTlN/5D=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=q1SmklWEbI0GZTwG+c+dRdMWdk8UZesq+wqhTSVxPs7gvZfAtyaMffR0E0vlcw+MaPcDgwqIdON3oIYa9xToJ3fojSZD82/LPHoim4yieDi19Xzus7g9AtGVV7dpv7qo+DLgPOuBSV3wbwtAUsizd5h3dkPTHgWfRKnjdYAdXR38NzmG0EdFg0dnr+jkav+FsHFTauC83DXkJvXu+9SlV1dH5NS3NcdUyHh7sRlmcX8iOAE6uXOffI6sD6DAchqp7YDGj9CctT+zJR+a1oDtUEBXYd13leqpuEiV6k6nIv8l0sWHQ00CBPNi5j83Vw3QEKFxJekyPPPVg86fZGFaNQ==
X-YMail-OSG: PKiRwSwVM1nV25EBlsGz91uxIaJ.bwp0GAK7ZEjixw_SiRJqLUpiEEXhe4Fw2RR
 1MObmSZxauHXk5LCmnSVBb3DtvM2B1M429wqCxPFFCGUJ.UOJpuhiE1GY7.BxmUqxqqZ9sQ4432d
 zJhAZV3_RNf8Gz6FO6HymGW6_aqpxI55jDUqIOmH_N528YrAofSW.3lvUu4wpJiThepoUAVTTtAJ
 njU2hRDvryR7lpyjdQJMdeVVmoosu4Yfi26XN3HV9VlJjUsUeP0XZgkTACdD34ZNZnam.wpOV99c
 RZq1HB8.2EtnL3PEE3OIgFetG4ZVtfFHPDZo_CaQCv8YEpSf3VUEMrZrgBomtHN.XhyxkUHfWrmI
 WKzlhBG3PnwGcFYcCzuivhesfyVMkh33Al3wZDx83RzrIck8h6TzS15dwrJP4E4zanD8ugRum61V
 IQTbUIFVs_t310Nee4_Ey0R7VGfWRg3xjnCoMTE99ctS4g1DznE6I2ekuPBQ1u8qBKIdhQ1EDUPg
 g_.UQQFmUe2dQnZ3PaiOBgU3PtYcdlDaJZ7RPbfhoO81M9xE3Hnj5gq_HK8DsdliW87bUdlUNUBW
 UwDsjsXiXn0rDswg59JOeb4BS3Pirh3_uLZMGwgC1bgf0FwpBKEe7SfTOC5lvwRmq1qjNrbFAyrC
 7aegkuUA5uPSwThl8pMbOZY_dlBH75Pdr1Q.fTMXwNSozfbE_BasZIBHjmX_XXmiD_6J3e03QLej
 1Xn8XA9qE_PWWo18b3vIZ2QcSh1iA8lji46yqemZM276bJv8rzQtQPja5Xvxb6PG9qru_HR7xulj
 oS2kAqywIrUOkinbNQcrJVKEno7_Ul0mlCgYIBMf17sgoyUtrNkVnl3me1IPJi1EgI3HHRir4A1S
 .U2vxOM_JpNZuj16tOplyTl0tE4U9k6EFCyOQ2B8ZNMascdfTSPilsi4SFPLGAZtSh60EsC5dxxw
 EVRiL1rnXU8pgEkz4ABjPCVmE1FVAGdhflZDRjij4_97osOcubE0.DgKC7NthT1tclkm9JssSxgC
 LIhv.WuOBaKjfMnOZ8Iu0_6wUsgtvLSZEse15gBkl5AzYHMlkx.38yryV8gUQeqyD1SS1aO4SH.1
 cgE53ZBE2kJEbSmHvYX48oddb1i0aUPlkxRKvZxw3.sU9ufruWjMPtJI4h3eODD.3jL7HonEZ3Yq
 mTaJesFQqKkxrt4MJqD2lwcM3LDJTOeTqfO8AMOI2Sj4Ul3lhuH_5x7WerGeWAV7m4_UeO46R8Ag
 o7FyBoHhoSdkACKc9QsklLNByLaVZSIuKt0uEvaOGs3Bc5M4oaitg4UkRS2_PzOXHzljBDAk3rcm
 u8JPbWanKT7J6Tp5MbDYoemsKUbVqemJnGrKFInS17GrORbRhPJB193fmXTgbdvMELu6BxoDpG5E
 OBPruOR.grMc5j_cxMaEEmbPa7rCsJscHqsygnLSt1sffPslNPHNrLAc_pcP2dT08DcAe4ak0Riv
 d3uKQWzbS51YaqmPVdGvi8rjwWph8wiy1HrCBZQGEodIoc7T9MgLuEbmCVTAxxfldnFEGZfJQN7O
 pqJbRCj2B8I9uF6iqeWAcGmIcmf2E31r1A0aJY_j9_H3GRWUnY9VXvfjvPLviD.Ry9Sbf.Ke3nY1
 UIgeRVpHqWIsVEucF0kjXjlexGfaKX.tXxkkl.9BwU4.bwILc8FDToepyEviIriAFlMjBe9i97Xy
 biTzEIUhVRECRYhvw9dKd0hPFNiJM4UhIo49H0N9qVkm51b7qBGuwejZWtj8.GmDPS6patFT35hc
 5NwxQCI5owAwxU4IGBeP76oPOQHm0rff4vdnlCXZi9JwjSgiFgc0EKtALPNLMR8wvzfBdk0aKFeO
 zUmhKmsiS329L8DiZtG1oXS70z2Y3ZvciOvR8KO3XrJf0.ZIbnadCQJdtkai8o8Tg0qBimNAmEID
 9tVXfoc0CSWLOq9X9klRKVqg5lKn.G38yA4jFhSkmjYuhsuK6gWX9GzrfDB0qVHFUpdNbNAdeV_U
 ySg4St7fj.GN4xWggwWz0LxGrTRniaWq2bCSu8To9I2hhc4ekbcpeTSyWwYikZHLJtk5J5iQdigO
 okG_q_Ikb_I8kOm2WYOA5bGfmsi7qgkksZRHuEdj1lVxXsgaasZWc.2OAZdn6bC.N01jGfAXVCFV
 FcNkMoxppXtnkKO.IS5uTWuuqLRiDGWJeZwZhGsA51C8n5KWqTw8pISOmt3jahOphTvbCJjbWmiq
 jdRWrx7VX4.Fy4mEohNH7x4qdtMa3dGEk2uL717kwb9YAdwFm9wvHhM09Unz6dXzDT1xR1BQNHJY
 Z4gzpEmqgDcWeoQ--
X-Sonic-MF: <jason_a69@yahoo.co.uk>
X-Sonic-ID: 5f5c1825-7300-4a6b-aad4-b5429bf24705
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Mon, 24 Apr 2023 13:45:06 +0000
Received: by hermes--production-sg3-6d6fb994f6-gm72r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8a31b1329a9170230f0826cad2ab57fb;
          Mon, 24 Apr 2023 13:44:59 +0000 (UTC)
Message-ID: <2a699a99-545c-1324-e052-7d2f41fed1ae@yahoo.co.uk>
Date: Mon, 24 Apr 2023 21:44:43 +0800
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
Content-Language: en-GB
From: Jason Adriaanse <jason_a69@yahoo.co.uk>
In-Reply-To: <5f37b0b0-6cb5-b210-a894-d1e91976126e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

I took out "iommu=soft" and the server failed to boot, so yes it does break.

The first error was
ata7.00: Failed to IDENTIFY (INIT_DEV_PARAMS failed , err_mask=0x80)

On 24/04/2023 21:20, Robin Murphy wrote:
> On 2023-04-22 07:25, Jason Adriaanse wrote:
>> Hi Christoph,
>>
>> Sorry for my late reply, I have been on the road.
>>
>> So, if I boot with
>> intel_iommu=off
>> Then the server boots fine..although that is not a solution because I 
>> need Intel iommu for virtualisation.
>>
>> Also, I build all my kernels with CONFIG_INTEL_IOMMU=y
>>
>
> If you boot 5.15 *without* the "iommu=soft" argument, just 
> "intel_iommu=on", does that also break?
>
> Robin.
