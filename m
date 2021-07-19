Return-Path: <SRS0=4OKN=ML=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_REPLYTO,HTML_MESSAGE,HTML_NONELEMENT_30_40,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,MPART_ALT_DIFF,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0707C636C9
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 09:15:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7296115B
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 09:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7296115B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64119607BA;
	Mon, 19 Jul 2021 09:15:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w6js_nPYFWTJ; Mon, 19 Jul 2021 09:15:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 519F060667;
	Mon, 19 Jul 2021 09:15:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B86FC001A;
	Mon, 19 Jul 2021 09:15:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5F25C000E
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 09:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5F764022C
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 09:15:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=fudan.edu.cn
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 19qe4tLyIgiq for <iommu@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 09:15:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net
 (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
 by smtp2.osuosl.org (Postfix) with SMTP id 8DD7040229
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 09:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fudan.edu.cn; s=dkim; h=Received:Mime-Version:Message-ID:
 Subject:Date:From:To:Cc:Content-Type; bh=bbvnGJ169VK66Pl2rOYk9Fp
 SM0kpPoTf9qERkWSIq68=; b=iDkl88YxZ2BxiAtpHYiZ/OX3YFitKAIzc5Xg+JP
 3xMuLHPHDgjjqyq2C5XZBGIHRWsVyAsC1hGYQHdBRtIsrZS0O13TopEhEAfFTp4O
 LLUs2gdFyDMQxuw3cq+vs5UXNy+2+3sR2Z7wKditchJxr5WrtbqUQmew8/3WYCyZ
 c7ZQ=
Received: from localhost (unknown [39.144.45.47])
 by app1 (Coremail) with SMTP id XAUFCgD3GZ6eQvVgOGKKAA--.54619S2;
 Mon, 19 Jul 2021 17:15:11 +0800 (CST)
Mime-Version: 1.0
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
Message-ID: 
Subject: Re: [PATCH] iommu/amd: Convert from atomic_t to refcount_t on
 device_state->count
Date: Mon, 19 Jul 2021 17:15:10 +0800 (GMT+08:00)
To: =?UTF-8?B?V2lsbCBEZWFjb24=?=<will@kernel.org>
X-CM-TRANSID: XAUFCgD3GZ6eQvVgOGKKAA--.54619S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKry3Jr4DGw4xAr1DJr1xGrg_yoWDWrc_Aw
 s7Xr1vy39ayF4vy3ZFyFn3ZryF9r42yrWkZryv93y8Za4fGrWFqan5XryFgrs5ZF4qyFyY
 vFs3AayIv34xXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbRAYjsxI4VW5JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2vYz4IE57IF64xv32x2
 64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG67k08I80eVWUJVW8JwAqx4xG6c
 804VAFz4xC04v7Mc02F40EFcxC0VAKzVAqx4xG6I80ewAqx4xG64kEw2xG04xIwI0_Ar0_
 Cr1lYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
 kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACY4xI67k04243AVAKzVAKj4xxM4xvF2IEb7IF
 0Fy26I8I3I1lFcxC0VAqx4xG64xE4I8GawAKzVCjr7xvwVAFz4v204v26I0v724lw4CEc2
 x0rVAKj4xxMxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
 JVW8JwC20s026c02F40E14v26r106r1rMI8I3I0E7480Y4vE14v26r1j6r18MI8E67AF67
 kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
 6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMI
 IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
 WIevJa73UjIFyTuYvjxUOuWlDUUUU
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Cc: =?UTF-8?B?WGluIFRhbg==?= <tanxin.ctf@gmail.com>,
 =?UTF-8?B??= <yuanxzhang@fudan.edu.cn>,
 =?UTF-8?B??= <linux-kernel@vger.kernel.org>,
 =?UTF-8?B??= <iommu@lists.linux-foundation.org>
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
From: =?UTF-8?B?WGl5dSBZYW5n?= via iommu <iommu@lists.linux-foundation.org>
Reply-To: =?UTF-8?B?WGl5dSBZYW5n?= <xiyuyang19@fudan.edu.cn>
Content-Type: multipart/mixed; boundary="===============1396451643005782457=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============1396451643005782457==
Content-Type: multipart/alternative; 
	boundary="----=_Part_0_199937958.1626686110433"

------=_Part_0_199937958.1626686110433
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: base64


------=_Part_0_199937958.1626686110433
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: base64

PGRpdj5ZZXMsIEkgYWxyZWFkeSBzZW5kIG9uZSBwYXRjaCBhYm91dCBwYXNpZF9zdGF0ZS48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PjwhLS1lbXB0eXNpZ24tLT48L2Rpdj48ZGl2PjxkaXYgc3R5
bGU9ImZvbnQtc2l6ZToxMnB4O3BhZGRpbmc6MnB4IDA7Ij4tLS1PcmlnaW5hbC0tLTwvZGl2Pjxk
aXYgc3R5bGU9ImZvbnQtc2l6ZToxMnB4O2JhY2tncm91bmQ6I2YwZjBmMDtjb2xvcjojMjEyMTIx
O3BhZGRpbmc6OHB4IWltcG9ydGFudDtib3JkZXItcmFkaXVzOjRweDtsaW5lLWhlaWdodDoxLjU7
Ij48ZGl2PjxiPkZyb206PC9iPiAiV2lsbCBEZWFjb24iJmx0O3dpbGxAa2VybmVsLm9yZyZndDs8
L2Rpdj48ZGl2PjxiPkRhdGU6PC9iPiBNb24sIEp1bCAxOSwgMjAyMSAxNzowNyBQTTwvZGl2Pjxk
aXY+PGI+VG86PC9iPiAiWGl5dSBZYW5nIiZsdDt4aXl1eWFuZzE5QGZ1ZGFuLmVkdS5jbiZndDs7
PC9kaXY+PGRpdj48Yj5DYzo8L2I+ICJKb2VyZyBSb2VkZWwiJmx0O2pvcm9AOGJ5dGVzLm9yZyZn
dDs7IlN1cmF2ZWUgU3V0aGlrdWxwYW5pdCImbHQ7c3VyYXZlZS5zdXRoaWt1bHBhbml0QGFtZC5j
b20mZ3Q7OyJpb21tdSImbHQ7aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcmZ3Q7OyJs
aW51eC1rZXJuZWwiJmx0O2xpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcmZ3Q7OyJ5dWFueHpo
YW5nIiZsdDt5dWFueHpoYW5nQGZ1ZGFuLmVkdS5jbiZndDs7IlhpbiBUYW4iJmx0O3Rhbnhpbi5j
dGZAZ21haWwuY29tJmd0Ozs8L2Rpdj48ZGl2PjxiPlN1YmplY3Q6PC9iPiBSZTogW1BBVENIXSBp
b21tdS9hbWQ6IENvbnZlcnQgZnJvbSBhdG9taWNfdCB0byByZWZjb3VudF90IG9uIGRldmljZV9z
dGF0ZS0mZ3Q7Y291bnQ8L2Rpdj48L2Rpdj48YnI+T24mbmJzcDtNb24sJm5ic3A7SnVsJm5ic3A7
MTksJm5ic3A7MjAyMSZuYnNwO2F0Jm5ic3A7MDI6MDA6MzdQTSZuYnNwOyswODAwLCZuYnNwO1hp
eXUmbmJzcDtZYW5nJm5ic3A7d3JvdGU6PGJyPiZndDsmbmJzcDtyZWZjb3VudF90Jm5ic3A7dHlw
ZSZuYnNwO2FuZCZuYnNwO2NvcnJlc3BvbmRpbmcmbmJzcDtBUEkmbmJzcDtjYW4mbmJzcDtwcm90
ZWN0Jm5ic3A7cmVmY291bnRlcnMmbmJzcDtmcm9tPGJyPiZndDsmbmJzcDthY2NpZGVudGFsJm5i
c3A7dW5kZXJmbG93Jm5ic3A7YW5kJm5ic3A7b3ZlcmZsb3cmbmJzcDthbmQmbmJzcDtmdXJ0aGVy
Jm5ic3A7dXNlLWFmdGVyLWZyZWUmbmJzcDtzaXR1YXRpb25zLjxicj4mZ3Q7Jm5ic3A7PGJyPiZn
dDsmbmJzcDtTaWduZWQtb2ZmLWJ5OiZuYnNwO1hpeXUmbmJzcDtZYW5nJm5ic3A7PHhpeXV5YW5n
MTlAZnVkYW4uZWR1LmNuPjxicj4mZ3Q7Jm5ic3A7U2lnbmVkLW9mZi1ieTombmJzcDtYaW4mbmJz
cDtUYW4mbmJzcDs8dGFueGluLmN0ZkBnbWFpbC5jb20+PGJyPiZndDsmbmJzcDstLS08YnI+Jmd0
OyZuYnNwOyZuYnNwO2RyaXZlcnMvaW9tbXUvYW1kL2lvbW11X3YyLmMmbmJzcDt8Jm5ic3A7MTEm
bmJzcDsrKysrKystLS0tLTxicj4mZ3Q7Jm5ic3A7Jm5ic3A7MSZuYnNwO2ZpbGUmbmJzcDtjaGFu
Z2VkLCZuYnNwOzYmbmJzcDtpbnNlcnRpb25zKCspLCZuYnNwOzUmbmJzcDtkZWxldGlvbnMoLSk8
YnI+PGJyPkNhbiZuYnNwO3Bhc2lkX3N0YXRlOjpjb3VudCZuYnNwO2JlJm5ic3A7Y29udmVydGVk
Jm5ic3A7c2ltaWxhcmx5Pzxicj48YnI+V2lsbDxicj48L3Rhbnhpbi5jdGZAZ21haWwuY29tPjwv
eGl5dXlhbmcxOUBmdWRhbi5lZHUuY24+PC9kaXY+
------=_Part_0_199937958.1626686110433--


--===============1396451643005782457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1396451643005782457==--

