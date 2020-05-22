Return-Path: <SRS0=4l6Q=7E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95FCC433DF
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 14:53:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA672072C
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 14:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA672072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 419AD25C36;
	Fri, 22 May 2020 14:53:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EbHccTP3zfpf; Fri, 22 May 2020 14:53:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5CB062002D;
	Fri, 22 May 2020 14:53:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E667C0863;
	Fri, 22 May 2020 14:53:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A2C3C0176
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 14:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0166E88ADA
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 14:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xi6t-y3KxP7Y for <iommu@lists.linux-foundation.org>;
 Fri, 22 May 2020 14:53:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 92AE388A9D
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 14:53:35 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id C483E8A93724536F38DA;
 Fri, 22 May 2020 15:53:32 +0100 (IST)
Received: from [127.0.0.1] (10.210.166.164) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 22 May
 2020 15:53:31 +0100
Subject: Re: arm-smmu-v3 high cpu usage for NVMe
From: John Garry <john.garry@huawei.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20190821151749.23743-1-will@kernel.org>
 <b2a6e26d-6d0d-7f0d-f222-589812f701d2@huawei.com>
 <20200318205313.GB8094@willie-the-truck>
 <c6ab8020-dc06-0c7d-7a41-e792d90f97ba@huawei.com>
 <20200319184349.GA1697676@myrica>
 <c9ebe17d-66b8-1b8c-cc2c-5be0bd1501a7@huawei.com>
Message-ID: <4aacbd65-f1fd-55e0-c8bb-468badc9f600@huawei.com>
Date: Fri, 22 May 2020 15:52:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <c9ebe17d-66b8-1b8c-cc2c-5be0bd1501a7@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.210.166.164]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Marc Zyngier <maz@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 iommu@lists.linux-foundation.org, alexandru.elisei@arm.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAvMDMvMjAyMCAxMDo0MSwgSm9obiBHYXJyeSB3cm90ZToKCisgQmFycnksIEFsZXhhbmRy
dQoKPj4+Pj4gwqDCoMKgIFBlcmZUb3A6wqDCoCA4NTg2NCBpcnFzL3NlY8KgIGtlcm5lbDo4OS42
JcKgIGV4YWN0OsKgIDAuMCUgbG9zdDogCj4+Pj4+IDAvMzQ0MzQgZHJvcDoKPj4+Pj4gMC80MDEx
NiBbNDAwMEh6IGN5Y2xlc10swqAgKGFsbCwgOTYgQ1BVcykKPj4+Pj4gLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gCj4+Pj4+
Cj4+Pj4+Cj4+Pj4+IMKgwqDCoMKgwqAgMjcuNDMlwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKg
wqAgW2tdIGFybV9zbW11X2NtZHFfaXNzdWVfY21kbGlzdAo+Pj4+PiDCoMKgwqDCoMKgIDExLjcx
JcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBfcmF3X3NwaW5fdW5sb2NrX2lycXJl
c3RvcmUKPj4+Pj4gwqDCoMKgwqDCoMKgIDYuMzUlwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKg
wqAgW2tdIF9yYXdfc3Bpbl91bmxvY2tfaXJxCj4+Pj4+IMKgwqDCoMKgwqDCoCAyLjY1JcKgIFtr
ZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBnZXRfdXNlcl9wYWdlc19mYXN0Cj4+Pj4+IMKg
wqDCoMKgwqDCoCAyLjAzJcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBfX3NsYWJf
ZnJlZQo+Pj4+PiDCoMKgwqDCoMKgwqAgMS41NSXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKgwqDC
oCBba10gdGlja19ub2h6X2lkbGVfZXhpdAo+Pj4+PiDCoMKgwqDCoMKgwqAgMS40NyXCoCBba2Vy
bmVsXcKgwqDCoMKgwqDCoMKgwqDCoCBba10gYXJtX2xwYWVfbWFwCj4+Pj4+IMKgwqDCoMKgwqDC
oCAxLjM5JcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBfX2ZnZXQKPj4+Pj4gwqDC
oMKgwqDCoMKgIDEuMTQlwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqAgW2tdIF9fbG9ja190
ZXh0X3N0YXJ0Cj4+Pj4+IMKgwqDCoMKgwqDCoCAxLjA5JcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKg
wqDCoMKgIFtrXSBfcmF3X3NwaW5fbG9jawo+Pj4+PiDCoMKgwqDCoMKgwqAgMS4wOCXCoCBba2Vy
bmVsXcKgwqDCoMKgwqDCoMKgwqDCoCBba10gYmlvX3JlbGVhc2VfcGFnZXMucGFydC40Mgo+Pj4+
PiDCoMKgwqDCoMKgwqAgMS4wMyXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKgwqDCoCBba10gX19z
Yml0bWFwX2dldF93b3JkCj4+Pj4+IMKgwqDCoMKgwqDCoCAwLjk3JcKgIFtrZXJuZWxdwqDCoMKg
wqDCoMKgwqDCoMKgIFtrXSAKPj4+Pj4gYXJtX3NtbXVfYXRjX2ludl9kb21haW4uY29uc3Rwcm9w
LjQyCj4+Pj4+IMKgwqDCoMKgwqDCoCAwLjkxJcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKg
IFtrXSBmcHV0X21hbnkKPj4+Pj4gwqDCoMKgwqDCoMKgIDAuODglwqAgW2tlcm5lbF3CoMKgwqDC
oMKgwqDCoMKgwqAgW2tdIF9fYXJtX2xwYWVfbWFwCj4+Pj4+CgpIaSBXaWxsLCBSb2JpbiwKCkkn
bSBqdXN0IGdldHRpbmcgYXJvdW5kIHRvIGxvb2sgYXQgdGhpcyB0b3BpYyBhZ2Fpbi4gSGVyZSdz
IHRoZSBjdXJyZW50IApwaWN0dXJlIGZvciBteSBOVk1lIHRlc3Q6CgpwZXJmIHRvcCAtQyAwICoK
U2FtcGxlczogODA4IG9mIGV2ZW50ICdjeWNsZXM6cHBwJywgRXZlbnQgY291bnQgKGFwcHJveC4p
OiA0Njk5MDkwMjQKT3ZlcmhlYWQgU2hhcmVkIE9iamVjdCBTeW1ib2wKNzUuOTElIFtrZXJuZWxd
IFtrXSBhcm1fc21tdV9jbWRxX2lzc3VlX2NtZGxpc3QKMy4yOCUgW2tlcm5lbF0gW2tdIGFybV9z
bW11X3RsYl9pbnZfcmFuZ2UKMi40MiUgW2tlcm5lbF0gW2tdIGFybV9zbW11X2F0Y19pbnZfZG9t
YWluLmNvbnN0cHJvcC40OQoyLjM1JSBba2VybmVsXSBba10gX3Jhd19zcGluX3VubG9ja19pcnFy
ZXN0b3JlCjEuMzIlIFtrZXJuZWxdIFtrXSBfX2FybV9zbW11X2NtZHFfcG9sbF9zZXRfdmFsaWRf
bWFwLmlzcmEuNDEKMS4yMCUgW2tlcm5lbF0gW2tdIGFpb19jb21wbGV0ZV9ydwowLjk2JSBba2Vy
bmVsXSBba10gZW5xdWV1ZV90YXNrX2ZhaXIKMC45MyUgW2tlcm5lbF0gW2tdIGdpY19oYW5kbGVf
aXJxCjAuODYlIFtrZXJuZWxdIFtrXSBfcmF3X3NwaW5fbG9ja19pcnFzYXZlCjAuNzIlIFtrZXJu
ZWxdIFtrXSBwdXRfcmVxc19hdmFpbGFibGUKMC43MiUgW2tlcm5lbF0gW2tdIHNiaXRtYXBfcXVl
dWVfY2xlYXIKCiogb25seSBjZXJ0YWluIENQVXMgcnVuIHRoZSBkbWEgdW5tYXAgZm9yIG15IHNj
ZW5hcmlvLCBjcHUwIGJlaW5nIG9uZSBvZiAKdGhlbS4KCkNvbGxlYWd1ZSBCYXJyeSBoYXMgc2lt
aWxhciBmaW5kaW5ncyBmb3Igc29tZSBvdGhlciBzY2VuYXJpb3MuCgpTbyB3ZSB0cmllZCB0aGUg
bGF0ZXN0IHBlcmYgTk1JIHN1cHBvcnQgd2lwIHBhdGNoZXMsIGFuZCBub3RpY2VkIGEgZmV3IApo
b3RzcG90cyAoc2VlIApodHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vaGlzaWxpY29u
L2tlcm5lbC1kZXYvZmVlNjljOGNhMzc4NGI5ZGQzOTEyNzAzY2ZjZDQ5ODVhMDBmNmJiYi9wZXJm
JTIwYW5ub3RhdGUgCmFuZCAKaHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2hpc2ls
aWNvbi9rZXJuZWwtZGV2L2ZlZTY5YzhjYTM3ODRiOWRkMzkxMjcwM2NmY2Q0OTg1YTAwZjZiYmIv
cmVwb3J0LnR4dCkgCndoZW4gcnVubmluZyBzb21lIE5WTWUgdHJhZmZpYzoKCi0gaW5pdGlhbCBj
bXB4Y2hnIHRvIGdldCBhIHBsYWNlIGluIHRoZSBxdWV1ZQoJLSB3aGVuIG1vcmUgQ1BVcyBnZXQg
aW52b2x2ZWQsIHdlIHN0YXJ0IGZhaWxpbmcgYXQgYW4gZXhwb25lbnRpYWwgcmF0ZQowLjAwIDog
ICAgICAgIGZmZmY4MDAwMTA3YTM1MDA6ICAgICAgIGNhcyAgICAgeDQsIHgyLCBbeDI3XQoyNi41
MiA6ICAgICAgICBmZmZmODAwMDEwN2EzNTA0OiAgICAgICBtb3YgICAgIHgwLCB4NCA6IAphcm1f
c21tdV9jbWRxX2lzc3VlX2NtZGxpc3QoKToKCi0gdGhlIHF1ZXVlIGxvY2tpbmcKLSBwb2xsaW5n
IGNtZF9zeW5jCgpTb21lIGlkZWFzIHRvIG9wdGltaXNlOgoKYS4gaW5pdGlhbCBjbXB4Y2hnClNv
IHRoaXMgY21weGNoZyBjb3VsZCBiZSBjb25zaWRlcmVkIHVuZmFpci4gSW4gYWRkaXRpb24sIHdp
dGggYWxsIHRoZSAKY29udGVudGlvbiBvbiBhcm1fc21tdV9jbWRxLnEsIHRoYXQgY2FjaGVsaW5l
IHdvdWxkIGJlIGNvbnN0YW50bHkgcGluZ2VkIAphcm91bmQgdGhlIHN5c3RlbS4KTWF5YmUgd2Ug
Y2FuIGltcGxlbWVudCBzb21ldGhpbmcgc2ltaWxhciB0byB0aGUgaWRlYSBvZiBxdWV1ZWQvdGlj
a2V0ZWQgCnNwaW5sb2NrcywgbWFraW5nIGEgQ1BVIHNwaW4gb24gb3duIGNvcHkgb2YgYXJtX3Nt
bXVfY21kcS5xIGFmdGVyIAppbml0aWFsIGNtcHhjaGcgZmFpbHMsIHJlbGVhc2VkIGJ5IGl0cyBs
ZWFkZXIsIGFuZCByZWxlYXNpbmcgc3Vic2VxdWVudCAKZm9sbG93ZXJzCgpiLiBEcm9wIHRoZSBx
dWV1ZV9mdWxsIGNoZWNraW5nIGluIGNlcnRhaW4gY2lyY3Vtc3RhbmNlcwpJZiB3ZSBjYW5ub3Qg
dGhlb3JldGljYWxseSBmaWxsIHRoZSBxdWV1ZSwgdGhlbiBzdG9wIHRoZSBjaGVja2luZyBmb3Ig
CnF1ZXVlIGZ1bGwgb3Igc2ltaWxhci4gVGhpcyBzaG91bGQgYWxzbyBoZWxwIGN1cnJlbnQgcHJv
YmxlbSBvZiBhLiwgYXMgCnRoZSBsZXNzIHRpbWUgYmV0d2VlbiBjbXB4Y2hnLCB0aGUgbGVzcyBj
aGFuY2Ugb2YgZmFpbGluZyAoYXMgd2UgY2hlY2sgCnF1ZXVlIGF2YWlsYWJsZSBzcGFjZSBiZXR3
ZWVuIGNtcHhjaGcgYXR0ZW1wdHMpLgoKU28gaWYgY21kcSBkZXB0aCA+IG5yX2F2YWlsYWJsZV9j
cHVzICogKG1heCBiYXRjaCBzaXplICsgMSkgQU5EIHdlIAphbHdheXMgaXNzdWUgYSBjbWRfc3lu
YyBmb3IgYSBiYXRjaCAocmVnYXJkbGVzcyBvZiB3aGV0aGVyIHJlcXVlc3RlZCksIAp0aGVuIHdl
IHNob3VsZCBuZXZlciBmaWxsIChJIHRoaW5rKS4KCmMuIERvbid0IGRvIHF1ZXVlIGxvY2tpbmcg
aW4gY2VydGFpbiBjaXJjdW1zdGFuY2VzCklmIHdlIGltcGxlbWVudCAoYW5kIHN1cHBvcnQpIGIu
IGFuZCBzdXBwb3J0IE1TSSBwb2xsaW5nLCB0aGVuIEkgZG9uJ3QgCnRoaW5rIHRoYXQgdGhpcyBp
cyByZXF1aXJlZC4KCmQuIE1vcmUgbWlub3IgaWRlYXMgYXJlIHRvIG1vdmUgZm9yd2FyZCB3aGVu
IHRoZSAib3duZXIiIHN0b3BzIGdhdGhlcmluZyAKdG8gcmVkdWNlIHRpbWUgb2YgYWR2YW5jaW5n
IHRoZSBwcm9kLCBob3BlZnVsbHkgcmVkdWNpbmcgY21kX3N5bmMgCnBvbGxpbmcgdGltZTsgYW5k
IGFsc28gdXNlIGEgc21hbGxlciB3b3JkIHNpemUgZm9yIHRoZSB2YWxpZCBiaXRtYXAgCm9wZXJh
dGlvbnMsIG1heWJlIDMyYiBhdG9taWMgb3BlcmF0aW9ucyBhcmUgb3ZlcmFsbCBtb3JlIGVmZmlj
aWVudCAodGhhbiAKNjRiKSAtIG1vc3RseSB2YWxpZCByYW5nZSBjaGVjayBpcyA8IDE2IGJpdHMg
ZnJvbSBteSBvYnNlcnZhdGlvbi4KCkxldCBtZSBrbm93IHlvdXIgdGhvdWdodHMgb3IgYW55IG90
aGVyIGlkZWFzLgoKVGhhbmtzLApKb2huCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
