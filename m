Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C26C433F5
	for <iommu@archiver.kernel.org>; Wed, 30 Mar 2022 18:22:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE4C3848A9;
	Wed, 30 Mar 2022 18:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nJ3b3gBVC92J; Wed, 30 Mar 2022 18:22:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D8383848AB;
	Wed, 30 Mar 2022 18:22:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A52A1C002C;
	Wed, 30 Mar 2022 18:22:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BAD7C0012
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 18:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43D9760640
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 18:21:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=yahoo.ca
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qtYt1eYVf9ua for <iommu@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 18:21:20 +0000 (UTC)
X-Greylist: delayed 00:30:04 by SQLgrey-1.8.0
Received: from sonic309-21.consmr.mail.gq1.yahoo.com
 (sonic309-21.consmr.mail.gq1.yahoo.com [98.137.65.147])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8E29605D5
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 18:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048;
 t=1648664479; bh=S9N6/sBVLY/JAPayLt7qbZOjEkabiJDDqpnxGv3U+bs=;
 h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To;
 b=ocdUFXLGfpuCdtMlex7s0fu5qO7tg0fht0Chs6nFqdw4Ph9bS2/2ya1Y842QOQ/qHuJaaZQHMPi2NfrAgPbGwnvPG3i5+CF3WlHyIAT2bGQb7AtWns28MMZz7cgDEb53CaXDK5W5nRyKSuV77vV9Ws5DC8c4TGDmv6PQsadYL5WE7dq+uEZY4nJD5gzWo5BHof2D44eMEtNj53PBjw9PCnRLsPsv1QEQGgAdD94fpjButy/DdnFyBLTYPOfFPh9KNo37K6DSqFKX0g0hTOTubjPxA+NYHk7BPYhmZlbpDX+Yc7PEKP20LCoxY9jqtVWpD60COTSY4s6AmBsK7beFxw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1648664479; bh=0cflEbRaJCNhHYqOX4TzRdKEkjrrkeBY72WykVT+0Zj=;
 h=X-Sonic-MF:Date:From:Subject:To:From:Subject;
 b=BuQvoN96m8C1mzQa2jCS7Evp5+6eySeRKUtHezVqx05Ha+IjslOH+Vwtz5VZgWO1Q6t4D+j9RLYMZb1SXBAgtRxJiGtY57hjl2mN2PCzDqyUpqeDhGfDsaBMiLiVyeOOWQQosDRBTKe0creSBODV9cApR/ke1sp8wIsf5wpKz78XAJlRuky3X+UOuPun7SD56SxgPWX7QjEEemV00oh2oiaB1Ao5DrqR0fuDUm/YRIZ7u1TPG0/Sc0ubVlGzJ9kxn37leR38WTVA6Y/xIcMSgJOQ5liX88+5skI19yvOxTaPIHS6pixLNdWl4jxwBiTqiqNtKgEQ/PmaH8c1Lyz1zg==
X-YMail-OSG: QQbdEVsVM1k4R2Boazup.tObBxhfDZFeV9KJ4xvxBlCqx9j.SGPOSKU74yCbTiJ
 1jrdtYPhR4hVAOrFrq6JU2rt_v7LBwQ7CazExg22Ogvy4K0LsV86NqHpHHZ6T7CVgKNITynuakLM
 svflVxvT.DMtv2zZBPiwK6Pxbo2MrPTh0f5hivaFZIJ7PlzRDGPVugMnokFuWw54w75c.ff6r.sN
 Nud0AuaMJg1jBhxUY_1J5CMogbEIxQnnYs_NYi4JmAGY8svqsP7KwRYkEC0XkorUBCnQYoxhH.fA
 imhC3faLMSGBiBUleItrpAWPTR_nxeyhTob7NQ3zzzrzPJLarkKlFQDqQTeDyvQ..Rxw5LkdQwFg
 XLUN7NA6veAMevw5qJe4QErmSY1fliXBL.pSwF1urIcyrqV2uDWgYCVQoviv0we21Kca6dd5yXyg
 Md5T7s79v8_LGWx0TFJlOM7BhYsdpoW8fywZPNs8BiSeb9R4H88JOXPHw69nOj22ngxJJ2K_Ntnx
 hwjH7WLm2RpVvlF0OJnXp0yF8aBfFhaB6FkpIZTZMmiIvq6XOd8ohdGHJsLV1gYtSPYNJ_G9CM2f
 vUx5u.0KbpWLB8nOogPBx63n4QiobwamP8hbnfvN0m2x0qxM5qahcmgvVBE1HfgY70oD941EekK7
 iW4YL8cXjWOIeKTOLLhMwwvBE4aeV2w7lgxMqf4n7QOFr9LsIbb22jW2sL9RUCiY__rwG_mJlH3C
 vd57dO4mywiR0IkqvEz4TpJ2Z1GnvbyYmf9mv6gSJXKPKe10uw.LJEljT7ERNvrK05u2N1xGmhRj
 4Er7.C9xpqhE0DP5Gk2DISQYfKHg10g9oUv_0jZh4Tg1qeGPSyUEucl5OkMJeeKnRrvXHdkIXX3_
 C18kn445QpTBkhvhkgyAPlXsEhEWTGqTg6Cf8TEZt5yBF9oxvP3EdK4.ta.0jKHG79INsffzLy1a
 v5eeTuLUvbXdJIAr3l4ZHxz2xcKSgB2eJY8bEvWWF8P.qbOcfPq5TW36Pwlk717VFeIMMVlQdzJR
 bmNOMPA2i2EMUzUrnHuiW_eo750CkiGHPHh56pTMjW2j9cTNGVBen895FWqMOzVx4xkwKjYq6znw
 UP0VFXqBThjnFiNocpiDYrtQ8kpL_QfTwRsx0iRQWGRksqIjp6sGR8cKykFTDq9F1wgO.NPwPCaT
 ksSj_qgansF2dj5IBSlp2Bn6Px0t8OkqQKojIqNpAvNd8_4aPZo0DGYq8cZvphKzDTZ1QL32YIzq
 1MbYfo9cwyvMNJlSZyk9zWZ658xDgPzztt0euVEqfgPkdhgwgqW8L9ASFLUhCWNsGJxsxyZPOcnK
 .eG29_VEYWlbLpeLdiiDRetbQ.olJE3oC.9F2YXN_fddCE0TH1.aN83mllO2BK56tM5z1Y.O1BVx
 78kPuF4xsizdu8BeKzdi5qRhBMw86vWzl.yEX.yTzayL.tdVtF79p7OAutRTvVWbTvw7f.Uh6thC
 vuWTPd4r_UbW3MggUt0JiVLpSK0JN1rTwIPki1VtsIR3zWRFSMmgLE3iX8FP0FnIRVTdRniGldKA
 Jm7t25LpXGXCDBpnmiekjSIDmGbF4SDmwhAtrig8GRa3pUHk1lfiq02MLcl631YWWwn7Al956fP5
 x53LD1fGQSt6OK1DUrtmw1dzByoB7oJPOgm8QQUdp0n6OYyKDMqlWfEt8d2HAsfWPAITepxlgpyi
 9LweaJZrpZgWd3olCRA_ayvGhw11_6CFjjoD24h0Nf7oAkNDSxPsiGg2iIvC9nZzMJWUeYu6SB6_
 QeL_3y29vj5t1Je9wlBzbg3ciwjUIzF0FETIfmhthTRJLYVESwoRRoLb2fr6JoNYwgjcgpTy_7EY
 tR7NwgXGjkKdfAHnvULm._MUHri.P6T3Nuaos5a1LKI0w0UwP4cLgby41l0Tn_0jnyIQRKY8roKX
 kIoyKwlDqbDzWF1nvnzPm9DuEpyqSMljWFIyG9rWG7_rLxH1fWNF8aj3QKudaabbL66hcztKbdvv
 PnkClKyebtc42MeKtYkyJy4CGJmsPjD.sX_SwV7KLQGsftcJrAdgxZVoWxU5.Sb1BFbi0.Xnj6yP
 xi8RU83Y4MTsWzimXW72t52odekMjyCm30rVXxOEoNByIplg8G.ny8yn4zuGbjs.lsQpi1uC2cFA
 gbIo3Ch96c0wlVQiZkSiNCA6PsfJDmgQYGPpf7DtKfYF85RFy380ImOi_Zf3JnsH4ptu6xjM7.DU
 ddVd_FyN5UjokBJp33gzM_v.DFAl1cG3TMprPlLhgGwYsRzK.DZp7MIi2iDJAiZJBT6h0EDguULV
 eXvmyEq7JxDBY5Q--
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Wed, 30 Mar 2022 18:21:19 +0000
Received: by kubenode520.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 3767e03bf643ceaa3a5f31bec6822e45; 
 Wed, 30 Mar 2022 17:51:11 +0000 (UTC)
Date: Wed, 30 Mar 2022 13:51:07 -0400
Subject: "dma-mapping: remove CONFIG_DMA_REMAP" causes AMD SME boot fail
To: Christoph Hellwig <hch@infradead.org>, regressions@lists.linux.dev
MIME-Version: 1.0
Message-Id: <1648659326.eabkokyuym.none@localhost>
References: <1648659326.eabkokyuym.none.ref@localhost>
X-Mailer: WebService/1.1.20001
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Mailman-Approved-At: Wed, 30 Mar 2022 18:22:23 +0000
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: "Alex Xu \(Hello71\) via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Alex Xu \(Hello71\)" <alex_y_xu@yahoo.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

After a recent kernel update, booting one of my machines causes it to 
hang on a black screen. Pressing Lock keys on the USB keyboard does not 
turn on the indicators, and the machine does not appear on the Ethernet 
network. I don't have a serial port on this machine. I didn't try 
netconsole, but I suspect it won't work.

Setting mem_encrypt=0 seems to resolve the issue. Reverting f5ff79fddf0e 
("dma-mapping: remove CONFIG_DMA_REMAP") also appears to resolve the 
issue.

The machine in question has an AMD Ryzen 5 1600 and ASRock B450 Pro4.

Cheers,
Alex.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
