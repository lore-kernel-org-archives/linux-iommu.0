Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1128C433F5
	for <iommu@archiver.kernel.org>; Fri,  4 Feb 2022 05:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F7788407D;
	Fri,  4 Feb 2022 05:46:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rIIplP99VQEW; Fri,  4 Feb 2022 05:46:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7277F8407B;
	Fri,  4 Feb 2022 05:46:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46946C001A;
	Fri,  4 Feb 2022 05:46:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C81AC000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 05:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 25D9B60AEA
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 05:46:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yfHJbwJe1Vam for <iommu@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 05:46:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B43460AE7
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 05:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643953583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=3Xf1wPMD3j9dFO1xFqh1/jT1YBoslpaP5CAcxEPhntI=;
 b=c47xVysY0f4yvm5dBnE+E/apnaIJxaBd2Fkmsvi4Ou+3bOgEzAm47t7Z63wwl4lvVmLDMa
 S93Oc/97WbAOcpH9ch/ZpSHaPvyEr5Ta9vNkuEWXFAOpSqLnxKDXUC2w94KiJcFf7JA7Ji
 i0xXGwIOR4u/jEQZJZm4NwGpMNllpEw=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-a8igDv4lNziRHqVgNE3a1g-1; Fri, 04 Feb 2022 00:46:20 -0500
X-MC-Unique: a8igDv4lNziRHqVgNE3a1g-1
Received: by mail-oi1-f197.google.com with SMTP id
 bl33-20020a05680830a100b002cf47784c5bso3068549oib.3
 for <iommu@lists.linux-foundation.org>; Thu, 03 Feb 2022 21:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=3Xf1wPMD3j9dFO1xFqh1/jT1YBoslpaP5CAcxEPhntI=;
 b=H/Io6EqoyOnJy/HnQNnUDD6LcNsYaP73tBALyFCC70V2TSow1ZrfVd3p11ZwCCw3iy
 Mr4a97XjySuqLTddqu8/M5E75EjNc2rfdsNIPdgH52ms6k6JshjACBIYSoLuds+vHYag
 RFJoEUjDAJt7eLwPo6LCqiqyFJopSOYOWhvuvTZOugTEbBATY3iAq33qMQQorHeqx1tL
 FjCjwlu4AYRwOVB1eItpDuf7wVuPkWRFh7RvQBginLUfuxjQPyQvWaur4BIb/WsdBWb0
 LMawgT1LBZ/7aD+/3T7JKbmhvtYRBTUlC6cmpEBath7P5a5A8TpAUP2LcPnubtxoghVj
 G3vA==
X-Gm-Message-State: AOAM531yUzp4NmZnUqTb8yshYKhbnBMzc5V7hAeeF94CZ2eqCnxpch8V
 IBT3ba0quysM4HLSB3JkwBZIn4mh++K6UN8scdb0usndRifknKCM84v6aFYNuKGdYR7rbdZQQWl
 +lWCjG1KNo68xpacnmrs0uuBZo+pQQw==
X-Received: by 2002:a9d:2e8:: with SMTP id 95mr574052otl.355.1643953579684;
 Thu, 03 Feb 2022 21:46:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUwP7giNT5XCbnIuwBRLx6jg5b86uE4BZegIhZJiJLYk5qAL65ZYmPsINZ+DINFWXIJ0xqlA==
X-Received: by 2002:a9d:2e8:: with SMTP id 95mr574048otl.355.1643953579448;
 Thu, 03 Feb 2022 21:46:19 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
 by smtp.gmail.com with ESMTPSA id c21sm403878oto.55.2022.02.03.21.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Feb 2022 21:46:18 -0800 (PST)
Date: Thu, 3 Feb 2022 21:46:16 -0800
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
Subject: iommu non-strict mode for arm64
Message-ID: <20220204054616.cfqhygo3v7amrzvp@treble>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi all,

We've gotten significant slowdowns on arm64 with 4k pages compared to
64k.  The slowdowns can be alleviated by setting iommu.strict=0 or
iommu.passthrough=1.

Is there a reason x86 defaults to lazy iommu, while arm64 does not?  Are
there security implications which are specific to arm64?

-- 
Josh

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
