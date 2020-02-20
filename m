Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0F9C11D0C
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 17:32:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB22224672
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 17:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNepBQpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB22224672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9543587C10;
	Thu, 20 Feb 2020 17:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hNMyGy1rfkpt; Thu, 20 Feb 2020 17:32:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 073EB85C8F;
	Thu, 20 Feb 2020 17:32:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8E57C1D84;
	Thu, 20 Feb 2020 17:32:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10C64C013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 17:32:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E8DCD84368
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 17:32:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TtopTg23532m for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 17:32:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 10F61824E3
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 17:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582219942;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhtQcGBTl4nwp8gN4Hlxs7R2XI/3YERGs+eAbVjqzyU=;
 b=HNepBQpK5p5wD9t8EY45sY1m5BeVZiQFgsJaIAia+jtlFLB5hgwxL6PLpwKkP2hRmAcvkj
 BuTqK1RS4k1tCtgyptTCIK8DDwRwC4FQrZnnmnSBUX25ROk5iEKU+IzN+N8JmSTJLC2auk
 Pb6S0E3J/+TFhv8cw6LsmE0ntYP3lsE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-kygyw-PdMAWlN3ySiVMgXA-1; Thu, 20 Feb 2020 12:32:16 -0500
Received: by mail-qt1-f198.google.com with SMTP id u40so3114798qtk.1
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 09:32:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=qhtQcGBTl4nwp8gN4Hlxs7R2XI/3YERGs+eAbVjqzyU=;
 b=mElxU+q13sSsjl8L8Tyeb6/x1b5+112QP8mfUwtv5PSKheYoyM6hvMJiBbhfqTYegQ
 Y8t7vJ7sR6gT6qpmdBm5Pij79+Q1lWdxk7Dmg2gVVVzm96zi1hd7+khA8PTpWx0GPDf2
 4e8j/R7mlNPx+uVZ5vk9r911RLzGppHpmFp+h79youSI5qy3k0DQs+AFHpwKKGNcUBtN
 AN8tEP6oXuNj6d26F1Ie0eF5L8JjYhmnoSSCjg8hSczAbyEpbKg4oKsQ40Qpfv0QtbSJ
 qhm/niGobAnaVAZ6hczfRA3GiOAvjX52DZtDrUv7GxI+C6+pOFVYthdCM5145TQFInsf
 jk8w==
X-Gm-Message-State: APjAAAVYYkxHWx1YYxqYNdlmZbOEwbvsUSpXVB6uGQm2kS+AaQNW9rUM
 yWfWJhSsHRf8A4BnBmfNRdC+Ll7Pqcr+H1cnYX+fk3Fd+4hErLOaFQvL7lXrrk5LYsmQ0toTVf0
 NJ5K1IYicYbCO0R1jDF0be9hu+cTK8w==
X-Received: by 2002:ae9:c318:: with SMTP id n24mr30412677qkg.38.1582219936268; 
 Thu, 20 Feb 2020 09:32:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhBKg1zI+voTYvvRjbz8lPgbIU+/Asipm4OXQD300Mfs8AbIlFl3jf+jI9oBXC1LvQU7lC9g==
X-Received: by 2002:ae9:c318:: with SMTP id n24mr30412640qkg.38.1582219935836; 
 Thu, 20 Feb 2020 09:32:15 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id t187sm118485qke.85.2020.02.20.09.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 09:32:15 -0800 (PST)
Date: Thu, 20 Feb 2020 10:32:13 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: question about iommu_need_mapping
Message-ID: <20200220173213.moynvygrdzc66zqg@cantor>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20200219235516.zl44y7ydgqqja6x5@cantor>
 <af5a148e-76bc-4aa4-dd1c-b04a5ffc56b1@linux.intel.com>
 <20200220162441.bhnpwgsmj4vlp3ve@cantor>
MIME-Version: 1.0
In-Reply-To: <20200220162441.bhnpwgsmj4vlp3ve@cantor>
X-MC-Unique: kygyw-PdMAWlN3ySiVMgXA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gVGh1IEZlYiAyMCAyMCwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPk9uIFRodSBGZWIgMjAg
MjAsIEx1IEJhb2x1IHdyb3RlOgo+PkhpIEplcnJ5LAo+Pgo+Pk9uIDIwMjAvMi8yMCA3OjU1LCBK
ZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+Pj5JcyBpdCBwb3NzaWJsZSBmb3IgYSBkZXZpY2UgdG8g
ZW5kIHVwIHdpdGggZGV2LT5hcmNoZGF0YS5pb21tdSA9PSBOVUxMCj4+Pm9uIGlvbW11X25lZWRf
bWFwcGluZyBpbiB0aGUgZm9sbG93aW5nIGluc3RhbmNlOgo+Pj4KPj4+MS4gaW9tbXVfZ3JvdXAg
aGFzIGRtYSBkb21haW4gZm9yIGRlZmF1bHQKPj4+Mi4gZGV2aWNlIGdldHMgcHJpdmF0ZSBpZGVu
dGl0eSBkb21haW4gaW4gaW50ZWxfaW9tbXVfYWRkX2RldmljZQo+Pj4zLiBpb21tdV9uZWVkX21h
cHBpbmcgZ2V0cyBjYWxsZWQgd2l0aCB0aGF0IGRldmljZS4KPj4+NC4gZG1hcl9yZW1vdmVfb25l
X2Rldl9pbmZvIHNldHMgZGV2LT5hcmNoZGF0YS5pb21tdSA9IE5VTEwgdmlhIAo+Pj51bmxpbmtf
ZG9tYWluX2luZm8uCj4+PjUuIHJlcXVlc3RfZGVmYXVsdF9kb21haW5fZm9yX2RldiBleGl0cyBh
ZnRlciBjaGVja2luZyB0aGF0IAo+Pj5ncm91cC0+ZGVmYXVsdF9kb21haW4KPj4+wqDCoCBleGlz
dHMsIGFuZCBncm91cC0+ZGVmYXVsdF9kb21haW4tPnR5cGUgaXMgZG1hLgo+Pj42LiBpb21tdV9y
ZXF1ZXN0X2RtYV9kb21haW5fZm9yX2RldiByZXR1cm5zIDAgZnJvbSAKPj4+cmVxdWVzdF9kZWZh
dWx0X2RvbWFpbl9mb3JfZGV2Cj4+PsKgwqAgYW5kIGEgcHJpdmF0ZSBkbWEgZG9tYWluIGlzbid0
IGNyZWF0ZWQgZm9yIHRoZSBkZXZpY2UuCj4+Pgo+Pgo+Plllcy4gSXQncyBwb3NzaWJsZS4KPj4K
Pj4+VGhlIGNhc2UgSSB3YXMgc2VlaW5nIHdlbnQgYXdheSB3aXRoIGNvbW1pdCA5MjM1Y2IxM2Q3
ZDEgKCJpb21tdS92dC1kOgo+Pj5BbGxvdyBkZXZpY2VzIHdpdGggUk1SUnMgdG8gdXNlIGlkZW50
aXR5IGRvbWFpbiIpLCBiZWNhdXNlIGl0IGNoYW5nZWQKPj4+d2hpY2ggZG9tYWluIHRoZSBncm91
cCBhbmQgZGV2aWNlcyB3ZXJlIHVzaW5nLCBidXQgaXQgc2VlbXMgbGlrZSBpdCBpcwo+Pj5zdGls
bCBhIHBvc3NpYmlsaXR5IHdpdGggdGhlIGNvZGUuIEJhb2x1LCB5b3UgbWVudGlvbmVkIHBvc3Np
Ymx5Cj4+PnJlbW92aW5nIHRoZSBkb21haW4gc3dpdGNoLiBDb21taXQgOThiMmZmZmI1ZTI3ICgi
aW9tbXUvdnQtZDogSGFuZGxlCj4+PjMyYml0IGRldmljZSB3aXRoIGlkZW50aXR5IGRlZmF1bHQg
ZG9tYWluIikgbWFrZXMgaXQgc291bmQgbGlrZSB0aGUKPj4+ZG9tYWluIHN3aXRjaCBpcyByZXF1
aXJlZC4KPj4KPj5JdCdzIG1vcmUgIm5pY2UgdG8gaGF2ZSIgdGhhbiAicmVxdWlyZWQiIGlmIHRo
ZSBpb21tdSBkcml2ZXIgZG9lc24ndAo+PmRpc2FibGUgc3dpb3RsYiBleHBsaWNpdGx5LiBUaGUg
ZGV2aWNlIGFjY2VzcyBvZiBzeXN0ZW0gbWVtb3J5IGhpZ2hlcgo+PnRoYW4gdGhlIGRldmljZSdz
IGFkZHJlc3NpbmcgY2FwYWJpbGl0eSBjb3VsZCBnbyB0aHJvdWdoIHRoZSBib3VuY2VkCj4+YnVm
ZmVyIGltcGxlbWVudGVkIGluIHN3aW90bGIuCj4+Cj4+QmVzdCByZWdhcmRzLAo+PmJhb2x1Cj4K
PkhpIEJhb2x1LAo+Cj5Xb3VsZCB0aGlzIG1lYW4gc3dpdGNoaW5nIHRvIGJvdW5jZV9kbWFfb3Bz
IGluc3RlYWQ/Cj4KCk5ldmVyIG1pbmQuIEkgc2VlIHRoYXQgaXQgd291bGQgZ28gaW50byB0aGUg
ZG1hX2RpcmVjdCBjb2RlLgoKPlJlZ2FyZHMsCj5KZXJyeQo+Cj4+X19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj5pb21tdSBtYWlsaW5nIGxpc3QKPj5pb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+Pmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
