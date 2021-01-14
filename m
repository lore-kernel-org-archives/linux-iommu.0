Return-Path: <SRS0=IUlV=GR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADADC433DB
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 20:40:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397BD23A81
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 20:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397BD23A81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iits.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B637D86AB0;
	Thu, 14 Jan 2021 20:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cZVaaS7y6Hf8; Thu, 14 Jan 2021 20:40:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BFBD9869B9;
	Thu, 14 Jan 2021 20:40:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5DDDC0893;
	Thu, 14 Jan 2021 20:40:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2428C013A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 14:42:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B0854869F6
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 14:42:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QFL7YCaQHvHk for <iommu@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 14:42:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4052B85BEE
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 14:42:18 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id m13so6662365ljo.11
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 06:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iits-ru.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=4vl1gc2NnBl2JVEazYnJEkAN5n/EUwS/bpAvzr8jo0s=;
 b=h9PeG+6r5Gy8/3NT3kRUaLS7WR9snHyUZbi9K/JbbqnbduZXymus48w4TWHY8u+hVw
 DoYpaMRzOmqlttv8mZs0PAO4qkjEfFctfLAw/ZDaGesXgTdxApd4hS2fzUlEo9Kks5I4
 DTL7kW/qbz5IAxA0lsnsTDXKzBIrKCt4yUwGbIpEdPkQpztxx050dVs8HY231AF86pl9
 /h4QuE1Nj4P1byZ7nV+Hj6xmNWU8IonkirNojvmnPvcfDlpu4siCohfj7kLCJsTq3VtN
 3aJcWXz+lASLCf7gsnmN+K++wlh5YvtOCi2mqhE2rTZG8xsZ2QUceXeO/4ZZTHhogRme
 wcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=4vl1gc2NnBl2JVEazYnJEkAN5n/EUwS/bpAvzr8jo0s=;
 b=oxDF/W9j8oC26RNjE2nMFZ8jEKtKIjTLxoQSf3YJc5yi/GDw4jXtPH9E2E4nbTZ7+u
 JMR2Y++PjtpGwK/mlyIwJXx1OpMuK12qT4TwU+/LbSQIx7YhX2wE/yDXSPn27dBD1pH1
 JsweZks6ehLbgEQjiLryYoBJC0mslAF5Db5Rn5MBYcbzBSdj7whG1BuV3CjEs6QDz59P
 IK9QP+TkviFKd2UgOPIQtPt+nzxoWxUMqCBgDCi6+o+DvhPP103H/kz4JByrlRAyhJiZ
 /TeIIGKj19Ids1DQMtiEHXkp6oWCu5llq7icS7AxuskM9q7oVo+mS8X6j9m3dcJGPmR7
 kCvA==
X-Gm-Message-State: AOAM531tNql2IyI9mSkFvHXjbrvCsOcKemEEXaAiKcL1Q6jTX6Sb8RXw
 IzmTg8JCzKlHCKr9AptzbO9tdEjXq0nQXxk/SwfzGY4ndc/vNPC3
X-Google-Smtp-Source: ABdhPJyVO650UzBIwQ718ustgl0Nw9boLV4EiBp6pALhZH8niLKlss8Z1DJuwHAxskMq6mjqskIxe4n+KVVz+URsewg=
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr3162119lji.48.1610635336233; 
 Thu, 14 Jan 2021 06:42:16 -0800 (PST)
MIME-Version: 1.0
From: "Anton Gubar'kov" <anton.gubarkov@iits.ru>
Date: Thu, 14 Jan 2021 17:42:05 +0300
Message-ID: <CAP=18J5QjRpqix2eZgNgcUROPJXk_E0woE5J7DVT51eDGSfFAQ@mail.gmail.com>
Subject: Intel gvt-g with nvidia prime render offload causes several issues
 (regression)
To: iommu@lists.linux-foundation.org
X-Mailman-Approved-At: Thu, 14 Jan 2021 20:40:37 +0000
Cc: David Woodhouse <dwmw2@infradead.org>
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
Content-Type: multipart/mixed; boundary="===============6466354221502973082=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============6466354221502973082==
Content-Type: multipart/alternative; boundary="000000000000143c2b05b8dd438e"

--000000000000143c2b05b8dd438e
Content-Type: text/plain; charset="UTF-8"

Dears,

there is thread https://github.com/intel/gvt-linux/issues/162 discussing
issues when gvt-g is used in Windows guest while the host has prime render
offload enabled.

I have this issue as well and I did a kernel bisect between v5.7 (works
kind of OK, at least there are no qemu/guest crashes) and v5.8 and the
bisect landed on the commit 327d5b2fee91c404a3956c324193892cf2cc9528.

Thanks for your help.
Anton Gubarkov.

--000000000000143c2b05b8dd438e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dears,</div><div><br></div><div>there is thread <a hr=
ef=3D"https://github.com/intel/gvt-linux/issues/162">https://github.com/int=
el/gvt-linux/issues/162</a> discussing issues when gvt-g is used in Windows=
 guest while the host has prime render offload enabled. <br></div><div><br>=
</div><div>I have this issue as well and I did a kernel bisect between v5.7=
 (works kind of OK, at least there are no qemu/guest crashes) and v5.8 and =
the bisect landed on the commit 327d5b2fee91c404a3956c324193892cf2cc9528. <=
br></div><div><br></div><div>Thanks for your help.</div><div>Anton Gubarkov=
.<br> </div><div><br></div></div>

--000000000000143c2b05b8dd438e--

--===============6466354221502973082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6466354221502973082==--
