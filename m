Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88777C34022
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 19:50:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6712067D
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 19:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7HlJLmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6712067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1BCC685209;
	Mon, 17 Feb 2020 19:50:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jKWawfvkSptT; Mon, 17 Feb 2020 19:50:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 95520841D5;
	Mon, 17 Feb 2020 19:50:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88C92C089F;
	Mon, 17 Feb 2020 19:50:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B86FFC013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AEC8E85209
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:50:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gw+ZljcNHzE4 for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 19:50:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 94728841D5
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581969012;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gNniWaKO6cLGO+dIQOvLhhRagXQZ/USr9hJlmkNpWOY=;
 b=i7HlJLmIAjsPgtTdl6Zkx1HAJ/dCTxUlC2oonAdfyeL1s7pmgDqFKMc+UV/QCA8joJMNU0
 BNmERezipTNCeA+sNO5A8DTlf1jg+AZDpwhUcllC+gJz26J1Rj3256YyF6VfDff/ZCMAyT
 3We5GIhix6cRQ/Oic8f91nWimAUKmW0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-sJJArEUMN8CXbli14Yzcrg-1; Mon, 17 Feb 2020 14:50:10 -0500
Received: by mail-qv1-f70.google.com with SMTP id n11so10903235qvp.15
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 11:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=gNniWaKO6cLGO+dIQOvLhhRagXQZ/USr9hJlmkNpWOY=;
 b=WotAruxYJGHvyq1nQijn4wxL6wtw68ZQKM7VWLsPErdLGMXq022aDR86XomQSbCLqo
 91XXWi8LEbUlSK1YMOYTnVJ4XUTyq3eKH3bLVEWols+5Eph+rIH/tR5zRkcSwlMP/BwY
 P92pzMvtOngEwbDFb1Hof1edVyV6YbK6ESrjGWRO6FRi1g8Ea8QEqr/EIwEKnNP1t8ld
 XdWHSPAxNLro32Fn72Ko7Xh1CfsAFldUMtemU8xNryhYkFo1aNcvAeh6aQcvp9wmjYcJ
 BHtRbfGovuWHV7JkhzPEwMmfJ1pAiib+Hrrzss9XISAT7ZLDRRg0PyDF01QK4wus5aIM
 JaTA==
X-Gm-Message-State: APjAAAUQkFhfivZPivH1vqY0qAkDlGx4Y5ITRFMVFDCW6/W1JVb5P5kN
 1lIIaitFxaSUIPIEYXsUvKLP7AfOPdmtlPRFNdEqVESlTQ/lGkDhGXgPlslTGTUR5yE0esY2nOi
 CHrpjLy2lLgBXa10kBW74eBQEwh9NqQ==
X-Received: by 2002:a05:620a:1279:: with SMTP id
 b25mr14322636qkl.385.1581969010471; 
 Mon, 17 Feb 2020 11:50:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEz2fW3GrBa7Qc1v+rXsbwKMDxOkGqyFWXWzs6sQ1ePE7ymxQJi4Brq0/lHG4v1VDI2Vn48Q==
X-Received: by 2002:a05:620a:1279:: with SMTP id
 b25mr14322617qkl.385.1581969010237; 
 Mon, 17 Feb 2020 11:50:10 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id a72sm731107qkc.121.2020.02.17.11.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 11:50:09 -0800 (PST)
Date: Mon, 17 Feb 2020 12:50:08 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/5] iommu/vt-d: Add attach_deferred() helper
Message-ID: <20200217195008.kxl6n6ev2jchzcxc@cantor>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-2-joro@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200217193858.26990-2-joro@8bytes.org>
X-MC-Unique: sJJArEUMN8CXbli14Yzcrg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de,
 David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon Feb 17 20, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>Implement a helper function to check whether a device's attach process
>is deferred.
>
>Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
