Return-Path: <SRS0=5HPr=TQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FB4C04E87
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 08:21:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578892082E
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 08:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRRy5o6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578892082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2D6ADBA4;
	Thu, 16 May 2019 08:21:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B3AD3BA0
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 08:21:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 49EE087B
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 08:21:48 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id f8so895529wrt.1
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 01:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=OA6EHZ+rBgX+AI6HnQlVvtFA4GwIJHdDavuc+cgpLGY=;
	b=QRRy5o6JqhpIs0U1mNu7NcuApp351BGFoFqP8bY4PoYZU8Ph6zr7ktVOuVIIzwugw7
	+ifpQnYT7LkhqkJqopDjaJ+Hc0SBYfzmFD0IGKDpEz1+/+FVfiYk/HblSpCZNfaC4yLI
	MU0g9jk5JQVTT83cl5e8CX8eK5oNLGETe0+29S1ltzJXL8sPWs4wkRRHhUkR6+WY4j+i
	z0RSJmLPVHbHuwjZ3UDZDcQp+A6RMRJoOOTqq3qvFNyM8AW/S/s7uyFut5x+6PsCq04x
	6dQzYmLAd7W9EuWjFQL2ZZ66X//KfoPNDtlMrUfS3CtHqPWpSWstn1kPVlKBEh1NoHOZ
	GVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=OA6EHZ+rBgX+AI6HnQlVvtFA4GwIJHdDavuc+cgpLGY=;
	b=Rm9qJgupXVT9ZgFKQE6TOGkLQfzms5+LKQMVS2pLMETtjIpbXFxA4jYL3wBU8rj1Qy
	YC0o8my0oNLzLm9AQWL7uIAMQdggBEQuw0f6MGwVjTaPJhbgIv/XHMJ6XR5jw34oLjY9
	yoqvbRCCiTnQWjF3OEdhCme5F4LZ9ckxW88W0HWm4WpCw8yOXvtNABGK2rawMoKHFPkh
	WUswVKOhzj2ZXuADN/1w22+0JGTYGWuHB8gEFbIk2u1wmjOEe2WgaQQC9aI6BOkeboC1
	kUWCv7N2UM+s/U4gRYP/riR2SJ6CffrHBM/vsu2CWYRzwgmKFHwWtrGR4dXA8v+wtaBj
	x3fQ==
X-Gm-Message-State: APjAAAX3n278AgFXecxCZWA/TlLLI6SucERD9KwChza9ytMSkjEfl1aq
	yj5N2eA/kBl94r35AbqEess=
X-Google-Smtp-Source: APXvYqxkeYGoD/laDD7Ea90alg2fzAedjgG/rMQYh7GefFFIyxG/DJDlXfcZlQH6cNW1hgrgzhR07g==
X-Received: by 2002:adf:8068:: with SMTP id 95mr28208094wrk.174.1557994906868; 
	Thu, 16 May 2019 01:21:46 -0700 (PDT)
Received: from [192.168.99.70] (mail.unidataz.cz. [193.165.148.130])
	by smtp.googlemail.com with ESMTPSA id
	h11sm5589112wrr.44.2019.05.16.01.21.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 01:21:45 -0700 (PDT)
From: "StarostaCZ@gmail.com" <starostacz@gmail.com>
X-Google-Original-From: "StarostaCZ@gmail.com" <StarostaCZ@gmail.com>
Subject: Re: Linux crash when using FTDI FT232R USB to serial converter on AMD
	boards.
To: Oliver Neukum <oneukum@suse.com>, Joerg Roedel <joro@8bytes.org>,
	Johan Hovold <johan@kernel.org>
References: <04503197-a0a9-8b35-6c65-c10f296aab57@gmail.com>
	<20190429094847.GI26546@localhost> <20190503153716.GE11605@8bytes.org>
	<8748125e-f360-ff0e-ea15-699bce9e7747@gmail.com>
	<4e7f0267-eba8-81c3-4036-25924ea9df98@gmail.com>
	<1557911856.2950.10.camel@suse.com>
	<3e7ec2f2-ac47-a031-96ba-fa2b9f21ed2e@gmail.com>
	<1557913582.2950.15.camel@suse.com>
	<c57ccafd-7ad4-63e4-54c1-e1fb136ebeed@gmail.com>
	<1557928483.2950.18.camel@suse.com>
	<4a48a017-fbcb-619f-f2d5-4d627a673021@gmail.com>
	<1557993530.14649.0.camel@suse.com>
Message-ID: <b4c3eba7-758d-7951-afd0-d90a261346e8@gmail.com>
Date: Thu, 16 May 2019 10:20:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557993530.14649.0.camel@suse.com>
Content-Language: cs
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
	Mathias Nyman <mathias.nyman@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Dne 16.5.2019 v 9:58 Oliver Neukum napsal(a):
>>> 2.Send a new report to the corresponding mailing list
>> Which mailing list is correct?
> In that case linux-usb@vger.kernel.org
>
> 	HTH
> 		Oliver
>
Is there some rules how to send bug report? Or I can send report with 
"my amateur description"?

starosta
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
