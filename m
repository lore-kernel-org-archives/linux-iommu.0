Received: from sonic310-12.consmr.mail.ir2.yahoo.com (sonic310-12.consmr.mail.ir2.yahoo.com [77.238.177.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B05F15AC
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 02:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s2048; t=1680229248; bh=OtAg8B4DwN5lQoEG5b07DBHDw6ITOm/exrOo8aIF1og=; h=Date:To:Cc:References:Subject:From:In-Reply-To:From:Subject:Reply-To; b=AVVNrk2PQyZJdPnSUMoqv20CEBhkoUtsOTQRBQhwq/qInGHI8pN8NpQpXIGCBVDmJErUnZOlw521e3vyrgHOZhlTs6z+83HeDYzn5+HaNwd1qXW0jMhG8rqgaaGwLPDIeB+G5w3XaGBf2CxSRMbqtfkRrHOUxY9RMRY61eyzQnehe+OumvA44ekyh+LREyo64B13X3hbPq73NtMAiHH15K+F60or5GsJm5HdP7cTTLyXzbcRT6u9xPYEuX3o2xeQZx8SdBunyTwjRKHjD13WwU6BpCTtlHHax6DDhml7sD0E1zD7XGdCLj1tnI7+wsurqd0J03FFtsoAx7xk+4OYcw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680229248; bh=Vg021lpTr7tRKOCRW0aEi7BvTJzyT4kPAj9DdMX1hsu=; h=X-Sonic-MF:Date:To:Subject:From:From:Subject; b=iXcR4l0i2oQBu4nbvI5PuRK0n1p7MGkDjgNU2bKS7wT34VtCcw1WbYQw/7RzzmqYuybLoe4YWXG4n0oFkKUcxByTSPQGox2O6vDr6fBq38S8kx6+7lhEnnvAyCr1jNEpOoPHrUZWOx3w671Ab/Euxjv0GwSN+hBpmdd7aA1yJO0qHN0FbiOyc0jKJWjOeg8cSeu0OGHHJgNQeGAHscYz7aE86z5p6KeL03peLzO7gDHSNQkSrbJER15fvh1yn/hCHfm9/T7ofTr/9zJ6WHk5Ehn5PRMM8ZNtLxAcJx6piluro3JW+8rtNu63QYb4EabKAsLa41+w63EHK89hin4ioA==
X-YMail-OSG: 2cvO3RcVM1m6RWYq96e8WZidOP5ApKZppPa8Tmw69h0x_6d8zNiVkbPNgfcunk5
 itwVrez6RgGai2DzTWaj7en75urgnAXnb3ukjBXDEJ6ammIlZzBjKlzEeqCA8M6NB5oxjlFiBMYd
 rxklbSvPwHu398h5upbvEfttrdvFxgRmHr2KFveoUe6y0iimB3X0DrKvtVZBk.XnR2Y4FnKeA4Oo
 W7wLqBGufu4EhvPjNaaL0deufsGtdv4CSQ5S6e9X4BeX1bLXn1TphlQ7srOVbfBFU56g7oX2A8OR
 zAwI4KEoX2RHGvrzGAAJ9AxUU4ZENWLVs2u7UW1WswR0hiATVgsUWiq_N7b5n7w_irip0NfPENzW
 h1G_axngL7TCYejuN79kYLA5wqKf9vj7G7EjO34Ltcg79mXfIDCtb4zEJyNghRHlQDn925oqTWQk
 oQ34KlLqnYjil9ljkWkdtkbcY1vRE3b5hpqv7cL2.f93gF14JFbY1tlIJk0onkV4_N00rp.RXWhM
 kEotQ0LYqdvhAX2Bh6rCz7QcrK9FAzVO7w2y.57CTIHRz1izqKq5UF0xifkV4wr9Vh4mC2glHMSo
 HlGBZPzNMqtOKlH_DjXPKvQLGPW8facW57s9a0nfCCyD9yvRr7gxZDSOzyh_F_eiM9Y1U4WW9gtA
 qfN_UQPeBtlRqZgI1B8NATap24ViwVj8p0xtbEIDa5R2PRZHWrnENlokwjxND13_OjZ3b4smtej_
 B6f8TmC9YBKqxCl0NQntc2_qshrO2MwgiwVNyTHQGf26JC9OaZUYo7d4dxgxmfT2SjuJwClEg3ef
 jfNdaADKF_hQBnJ_J6CmebDXBHGKkOTIc9HQ.mQpYl40J9EMIiycIvXQ_xr_SCRwEkLrT822R_KT
 iLfUzWf8FDgcX9AaROvlMxpD40MwDpNiaXPWMlnY71UvQBuzDRt5YQAKaBqDT8M3Tz5u69Gcukzt
 _pSTFFRnbFfx89FDmTGkglqaqpRmuX9hdt5u9e7I5POTTYRPmGh.7f7EiIEEPFGMO8WYz0V_anjX
 PcgNj6O.w2X264tvQEW6Eu3MsslZ_rxPAdVGKVYQcF8qO44eV3V63OE.IIzo9rL91wgd.D6b_1vB
 7gtwHErcSZgchP2_u3nFWvIKcTNhGL0DXVIlfw3j6XFr9Ix8toHPGtVz5K1xh4NUP4DPDpPngFZS
 noGRaepyMf6sRf7LoxpVFC6sSVnmpyvvEBIIVbtG0bMnnYVwdOBIayVKPhv9vndOMXbQf9f3_ABP
 rXP2hRXTqYjIuSVnb2ut_q6YOH0okGgxWhtP9FG43mTfb41TXLSX_wf9X3JQUR_AvrqZ6_5a4jGF
 VHsfm1Td20EuJEb1jwiMkDm1eyzJZYOsNxLPtWHPp.ol.ESd4sgwXVEPtdjFk4Aq2mBtZXA1sZfi
 SzP2VrofmgexeshvUfYrBgVyAGhLRr.w3cI0BDAPRcuZsxcVGDqqQXgR4R9IJF5vRHKONIbO4ohN
 54m39.Pd5XuuHxD_jsVDVPKknTZ2Xy7ZBbmiTaMHYT9QC.wrgSAoWScAB_sBvtk4pQiTfabs2tlE
 mRcN740aN8RbMOY1kF.N6MDfOKLIEsgPRJs6OjOH8lNksrjUmXK4QS1VV26AGc6X3I6uf9U3SAGj
 QW7IVPZp1fo7p3zwMX4XwUOM_HHGRD7XHkNTmmRBt4Ck_lG6iZ.jNoPhHgCTltB5FlZyMb44r_WF
 iIfHVXwD_PpJ1VXNsxhPdr.BCJEp87VVKF.QGN4twrCAsAUpMqihd1ncp6TV1zsZ2ALgOEDSwN2G
 XFMvrJfyB2btFvz.Mr2sZiUH6_j.8XufMPEmyhxJzO5P1x2Xqm.5CeE1dsgPcXt91Z51NKsAeg11
 DmP40k04dxVjPj4yLSUQfN2WievU52UI4aq3H2A3q2f0ohBUO8Jc.UGx87Lihzz7MEwy9EgQON0A
 cOTT5jxIQP4RwKsz_2Le6LR53E_PolKEEiQPAEqHV.FGhHCDks12CrcSDPsfGn1UWDo.WSE1zqtl
 O00Jqfx5bBZZWpsQdaMN_wpEe4Db9BWZnVG5fFuyFJFHIGTr8LRef4YtDvGTVlvQ4L5XsBNMy_Pv
 vUetTSrJOgLNHNC9.i2Ov0MRfhWbC_vTogbny0sj6Ddo3ahqkUitHbVH90qgrEEH_1PI8D_nHwSL
 w_75XLiA6359sikYXjpPmGU8L1lytlt6kAEc4NKDUgYgwV2vAo04sZOYRmH.Pe4r14jwJc8_lYuu
 SZw2NuxHiVXcAo7_wXIZveaQbhizSKoELTQlI9ExK6T4gCUod3CH_EDgNlToKHvwMJnepzd5cKaf
 zJpClyg--
X-Sonic-MF: <jason_a69@yahoo.co.uk>
X-Sonic-ID: ba2b5d49-9ed3-40eb-a4bf-a5e2eda8ad5b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Fri, 31 Mar 2023 02:20:48 +0000
Received: by hermes--production-sg3-6d6fb994f6-5v57h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bfd3261e7617c2d1e3df9e32aff4593d;
          Fri, 31 Mar 2023 02:20:42 +0000 (UTC)
Message-ID: <04a94830-f626-2cd7-d220-7ba3025a409c@yahoo.co.uk>
Date: Fri, 31 Mar 2023 10:20:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: robin.murphy@arm.com
Cc: baolu.lu@linux.intel.com, hch@lst.de, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev
References: <01c50370-002d-5e18-3edc-81c9527aedc9@arm.com>
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
Content-Language: en-GB
From: Jason Adriaanse <jason_a69@yahoo.co.uk>
In-Reply-To: <01c50370-002d-5e18-3edc-81c9527aedc9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi Christoph and Robin,

Christoph - I would like to send you more dmesg information but as my 
boot device cannot be detected that information is not being written to 
disk. Is there any way to specifically write boot debug information to 
say a USB device with some kernel parameters?

Alternatively, I could boot from a USB device.

Jason


