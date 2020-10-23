Return-Path: <SRS0=xWGd=D6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E70C4363A
	for <iommu@archiver.kernel.org>; Fri, 23 Oct 2020 13:31:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD46208FE
	for <iommu@archiver.kernel.org>; Fri, 23 Oct 2020 13:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqxMHyxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD46208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3379686DBA;
	Fri, 23 Oct 2020 13:31:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6v3V6ORzMje8; Fri, 23 Oct 2020 13:31:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 056FC86E1D;
	Fri, 23 Oct 2020 13:31:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDF0CC088B;
	Fri, 23 Oct 2020 13:31:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 161C4C0052
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 13:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F07B486DDC
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 13:31:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bWZwuVWKRxLa for <iommu@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 13:31:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C4E1886DBA
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 13:31:03 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id l24so1543351edj.8
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+Xktd1fxP40CWJFM1jy30H8ussuycAV5mskqffDln2o=;
 b=bqxMHyxEWS14502z6xrwi3KaUAsTA5SaQKBiqCo57rL8XVwGal6C7chrnrNbulQCa2
 g5eS76psPWeyxUKhONIMwmZlnaS1FPBH1XrfoXCAFjb5pFgk+PDQ66MMTX82BzRh1A5q
 CK6WhrwmmppDIEebc9peddwq3iRyC+723fzz0+6BJzQt4a7SxrWhKrsuTLON8IP6SkCO
 BBszpvpr3ooTKZu5Ra11j003IPVYeSqAdkXCG108c7Cu8U4oQHpvXxa2c4kYg1Jh7UIt
 juRKWA0xCi2MQ4U8UMRIQZmLEhOExPCJleN4+u+p3EMPukCQkgImVx+o45Eo4yy292fI
 4utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+Xktd1fxP40CWJFM1jy30H8ussuycAV5mskqffDln2o=;
 b=cBvuinPnoBeSPYjWdLWnuXPCPoqON82ELQ+L8+Pu9Qpbnob21f5wsMUCmJ7ITsT4fy
 blTB102VWiUkQvAk4KjShFjlpTF3surLrMJcLi26O0NlCAIKk4+HBiMXGneVx1+YxQxz
 uLV6yJ5OLg/KwTVmb5K0fP7wEPSFJgrQ8r2FZlDBrhQr944uvO2GBC4zArZaP4uX92Xr
 62aizgo8/VVYLpkrYT4XHMvaIygCmrz3KF9Hy2071hEvzmONtQuN0W61/LqNI5JUXxvw
 97TSxYULrfR4Rr/kUfzzXkwBTYNKkdN+xHkLPsKyTvakWNesStwQ10J1TMrtyGMdhgfy
 UyKg==
X-Gm-Message-State: AOAM532f+ONDdyLfIYaj02+gtjCqdSTCUWyt48qdIV0gtT6vOgPdrvJg
 e/jzTIqBLKchYMi/jIVZEIA3eg==
X-Google-Smtp-Source: ABdhPJyerbyLeRW1OUwcQivBu3uvKQxf96P9/VcEbVPZll6+IDia+owxg1JQS2cXpVGg1gDI671+Ww==
X-Received: by 2002:aa7:dd53:: with SMTP id o19mr2215297edw.370.1603459862035; 
 Fri, 23 Oct 2020 06:31:02 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id sb29sm833964ejb.76.2020.10.23.06.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 06:31:01 -0700 (PDT)
Date: Fri, 23 Oct 2020 15:30:41 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] iommu: Avoid unnecessary PRI queue flushes
Message-ID: <20201023133041.GE2265982@myrica>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
 <20201015182211.GA54780@otc-nc-03>
 <20201016075923.GB1309464@myrica>
 <20201017112525.GA47206@otc-nc-03>
 <20201019140824.GA1478235@myrica>
 <20201019113316.2957c5f0@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201019113316.2957c5f0@jacob-builder>
Cc: kevin.tian@intel.com, "Raj, Ashok" <ashok.raj@intel.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, "Lu, Baolu" <baolu.lu@intel.com>,
 Jacon Jun Pan <jacob.jun.pan@intel.com>, linux-pci@vger.kernel.org,
 zhangfei.gao@linaro.org, dwmw2@infradead.org,
 linux-accelerators@lists.ozlabs.org
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

On Mon, Oct 19, 2020 at 11:33:16AM -0700, Jacob Pan wrote:
> Hi Jean-Philippe,
> 
> On Mon, 19 Oct 2020 16:08:24 +0200, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> 
> > On Sat, Oct 17, 2020 at 04:25:25AM -0700, Raj, Ashok wrote:
> > > > For devices that *don't* use a stop marker, the PCIe spec says
> > > > (10.4.1.2):
> > > > 
> > > >   To stop [using a PASID] without using a Stop Marker Message, the
> > > >   function shall:
> > > >   1. Stop queueing new Page Request Messages for this PASID.  
> > > 
> > > The device driver would need to tell stop sending any new PR's.
> > >   
> > > >   2. Finish transmitting any multi-page Page Request Messages for this
> > > >      PASID (i.e. send the Page Request Message with the L bit Set).
> > > >   3. Wait for PRG Response Messages associated any outstanding Page
> > > >      Request Messages for the PASID.
> > > > 
> > > > So they have to flush their PR themselves. And since the device driver
> > > > completes this sequence before calling unbind(), then there shouldn't
> > > > be any oustanding PR for the PASID, and unbind() doesn't need to
> > > > flush, right?  
> > > 
> > > I can see how the device can complete #2,3 above. But the device driver
> > > isn't the one managing page-responses right. So in order for the device
> > > to know the above sequence is complete, it would need to get some
> > > assist from IOMMU driver?  
> > 
> > No the device driver just waits for the device to indicate that it has
> > completed the sequence. That's what the magic stop-PASID mechanism
> > described by PCIe does. In 6.20.1 "Managing PASID TLP Prefix Usage" it
> > says:
> > 
> > "A Function must have a mechanism to request that it gracefully stop using
> >  a specific PASID. This mechanism is device specific but must satisfy the
> >  following rules:
> >  [...]
> >  * When the stop request mechanism indicates completion, the Function has:
> >    [...]
> >    * Complied with additional rules described in Address Translation
> >      Services (Chapter 10 [10.4.1.2 quoted above]) if Address Translations
> >      or Page Requests were issued on the behalf of this PASID."
> > 
> > So after the device driver initiates this mechanism in the device, the
> > device must be able to indicate completion of the mechanism, which
> > includes completing all in-flight Page Requests. At that point the device
> > driver can call unbind() knowing there is no pending PR for this PASID.
> > 
> In step #3, I think it is possible that device driver received page response
> as part of the auto page response, so it may not guarantee all the in-flight
> PRQs are completed inside IOMMU. Therefore, drain is _always_ needed to be
> sure?

So I don't think that's a problem, because non-last PR are not handled by
IOPF until the last PR is received. And when the IOMMU driver detects that
the queue has been overflowing and could have auto-responded to last PR,
we discard any pending non-last PR. I couldn't find a leak here.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
