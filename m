Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4588DC4743F
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 06:51:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A64611C2
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 06:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A64611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA2CF605E8;
	Mon,  7 Jun 2021 06:51:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KNx9d7g9DSdB; Mon,  7 Jun 2021 06:51:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA6326071E;
	Mon,  7 Jun 2021 06:51:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C25AC000D;
	Mon,  7 Jun 2021 06:51:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47718C0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 06:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2784D835C9
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 06:51:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F9N9zJaZ4kvz for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 06:51:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D8378356E
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 06:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623048711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4o9AFYShIiOudrYVWqeWOS4+by7917Hd7h/BZiXVljU=;
 b=X45me0Gwqz9wl1L9+aoUL5C+rkTSMayH2FSz74hlB+NWalm/yQO7KvDsnwaqcpvIxQUjtE
 8i2akwRZKAJtlLwVKOXxGWeKneLzO9qECQVF4VJd/oEWK8s3o6i0Fg58kCUsP52baxezbX
 RBz5/U6/3IoGbL92SnOMn0DxOCY1PxY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-jaPo24J9NIafWoRL1iXvXA-1; Mon, 07 Jun 2021 02:51:47 -0400
X-MC-Unique: jaPo24J9NIafWoRL1iXvXA-1
Received: by mail-wm1-f69.google.com with SMTP id
 p19-20020a1c54530000b029019d313d614dso2084416wmi.5
 for <iommu@lists.linux-foundation.org>; Sun, 06 Jun 2021 23:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4o9AFYShIiOudrYVWqeWOS4+by7917Hd7h/BZiXVljU=;
 b=gIHE98T5jvIre5vK+MvUVBhNdI0Nr/w5pxfmiw2UYjAAPMoKkYHQgzZXZVzlaRVsGk
 +PqzzatJVXf+5q0tKB1EvKIesKcb13JN7NDkojUKuQtm5Ow76sb+YAzcPPNXjRjK4KFh
 lpq3tUOiDgvRH5ZXNuAfT3I5SEDxSXg/E8XlVDsSlFJBpSPCiqbNmdwohBEwXJ5LDfV0
 A6FPpxyRI0GI1xetJhBFtmgm0XvStM9PJf5b6MlBYZzhtQ7kaZX6X4PkapVy7xm/u19J
 5i4K7pD3nE/x7D2R76rIU0UXlBQ4NG0m7JGVfsEHROj57EvHulrriAuIAYIW0B9rP8wp
 s/qQ==
X-Gm-Message-State: AOAM532UPTqs9ychcr6gGVCShaBsySYfEODkHd24/mjHbFVizKi1QZTi
 asRSIIrSb9HcfSy5yvwIeNQtNgOmi0werhWWgx7rg9mBYlYfrfOPkj4WFnF3QIPCn5wArO5Ie7u
 hx+cDsmCa9U/j0J+crmKAuM/jBeetlg==
X-Received: by 2002:adf:f5c9:: with SMTP id k9mr14884342wrp.180.1623048706568; 
 Sun, 06 Jun 2021 23:51:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjl6kAxqdninZuAYWFjtkVqJV6rZp5he0mQ6HQTxXN95BQKqkqQuB5NoWIDG/dxC45jrIuBw==
X-Received: by 2002:adf:f5c9:: with SMTP id k9mr14884320wrp.180.1623048706334; 
 Sun, 06 Jun 2021 23:51:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id o6sm16499918wre.73.2021.06.06.23.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Jun 2021 23:51:45 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20210603201018.GF1002214@nvidia.com>
 <20210603154407.6fe33880.alex.williamson@redhat.com>
 <MWHPR11MB1886469C0136C6523AB158B68C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210604122830.GK1002214@nvidia.com>
 <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <20210604152918.57d0d369.alex.williamson@redhat.com>
 <MWHPR11MB1886E95C6646F7663DBA10DD8C389@MWHPR11MB1886.namprd11.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9dc6c573-94df-a7c1-b4df-7f60fc3cf336@redhat.com>
Date: Mon, 7 Jun 2021 08:51:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1886E95C6646F7663DBA10DD8C389@MWHPR11MB1886.namprd11.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 07/06/21 05:25, Tian, Kevin wrote:
> Per Intel SDM wbinvd is a privileged instruction. A process on the
> host has no privilege to execute it.

(Half of) the point of the kernel is to do privileged tasks on the 
processes' behalf.  There are good reasons why a process that uses VFIO 
(without KVM) could want to use wbinvd, so VFIO lets them do it with a 
ioctl and adequate checks around the operation.

Paolo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
