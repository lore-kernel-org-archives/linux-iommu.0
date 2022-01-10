Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98996C433FE
	for <iommu@archiver.kernel.org>; Mon, 10 Jan 2022 02:43:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3641581A58;
	Mon, 10 Jan 2022 02:43:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6qxxWu9crnlB; Mon, 10 Jan 2022 02:43:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C93381886;
	Mon, 10 Jan 2022 02:43:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F13F6C002F;
	Mon, 10 Jan 2022 02:43:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E66FDC001E
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 02:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF690401F1
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 02:43:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LB6niVpBR2Y6 for <iommu@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 02:43:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3771640374
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 02:43:17 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id w7so10679498plp.13
 for <iommu@lists.linux-foundation.org>; Sun, 09 Jan 2022 18:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=qyKCKCCmcuULoAA1E8bR7TAp/hXUDe7XCt+iKUscsLk=;
 b=d204BN7YeRalLSQLTofWmZ6ROqqMwa0ciqG++whwPpQZ8LnMOSnF622TXHwDxURXep
 RIrcvqT9AQU09Lfw5mMe2Ip4VaO5vINC+TVSz8L2XCTzjKrrm5Fzatae3eT+9hocFK3w
 MMkAu13bYACIkkU53ka3q6+el8HPWVkQIUm7IRExDGqM2QHr613LuUZTOneEw8j67LSB
 cK8vcN4suSP+xcV1jmqO56uKFvmYV4yvPXvM90fgxEzw660DbCuDMjZ8Ez2rWe9hGZvL
 TH5VHSl9lP8SNsRCrTbLYmymDTqXYLrLvJ4NKjHfhAXR/S4wRLMgrT8iNAxk+ndXg7AZ
 yShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qyKCKCCmcuULoAA1E8bR7TAp/hXUDe7XCt+iKUscsLk=;
 b=etDhxDjw53VtMjPRTo7Tol64YMoQfRY/ttQWK6FDO1JKrcbRKAF8EuXFUPAPo5bHy6
 +kNfv4MkdqKQP44xnEb6w69VMgV2DfiajTQvjLgNjIe47k93zCJ6RacAXlmzJOKETRtR
 FYgDR2eNcTgOmD7bjdtYgw2C7fYVJutcTngjkjpjE3Dx/bABXgaJS9BlOoEUKx8v+YbD
 q2j1dxDR7EWK+wO+ELANr223RR9kLULCWuLxrooQHUSXkRInzVWnzPpWBa2d4aYZgaDx
 qp0h1NjcDOFdu6tkc04LtMySAwD2pfp4uwc7wK3I0mElHo1ft+Z3BHxR7QYNlI6dQC6D
 MILg==
X-Gm-Message-State: AOAM532/YDYKGzFiseTe1MDDGj93BwXpmtW0s+X05IDX9i3XTR4a5G9l
 xJqaS9S2V1NAm/UBt+K3tOY=
X-Google-Smtp-Source: ABdhPJzHvpcwy8jtSMlMuIpFbtSWWCI2itQfdxxE917XOCLsIRhv3vWHpnz1Tp+2gCkbVLApMuioeQ==
X-Received: by 2002:a17:902:9a8b:b0:149:be04:40ab with SMTP id
 w11-20020a1709029a8b00b00149be0440abmr32242215plp.159.1641782596662; 
 Sun, 09 Jan 2022 18:43:16 -0800 (PST)
Received: from VICKYMQLIN-NB1.localdomain ([159.226.95.33])
 by smtp.gmail.com with ESMTPSA id o11sm4883817pfu.150.2022.01.09.18.43.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Jan 2022 18:43:16 -0800 (PST)
Date: Mon, 10 Jan 2022 10:43:13 +0800
From: Miaoqian Lin <linmq006@gmail.com>
To: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH] iommu/omap: Fix missing put_device() call in
 omap_iommu_probe_device
Message-ID: <20220110022531.GA61@VICKYMQLIN-NB1.localdomain>
References: <20220107080428.10873-1-linmq006@gmail.com>
 <de3a3e1c-6c51-e951-cc7f-9ce2ccb3f283@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <de3a3e1c-6c51-e951-cc7f-9ce2ccb3f283@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "Nagalla, Hari" <hnagalla@ti.com>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Hi Suman Anna,
On Fri, Jan 07, 2022 at 08:42:16AM -0600, Suman Anna wrote:
> Hi Miaoqian,
> 
> 
> > Add the corresponding 'put_device()' in the error handling paths.
> 
> Also, need it in the regular path, not just in error handling path.
I think after calling platform_get_drvdata() normally, the
reference will be released in other functions, so don't need it in the
regular path.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
