Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5392EC5519F
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 15:30:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC15124198
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 15:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G03gADzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC15124198
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1837487024;
	Tue, 17 Nov 2020 15:30:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8odO3gHmOvSv; Tue, 17 Nov 2020 15:30:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B17598700D;
	Tue, 17 Nov 2020 15:30:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CE8CC0800;
	Tue, 17 Nov 2020 15:30:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E359BC07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 10:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DE5FD8709B
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 10:53:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kgC46z9uzFmK for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 10:53:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 42BCE87098
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 10:53:01 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHAhpBN075294;
 Tue, 17 Nov 2020 10:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=IodeTKUioP4hbL7In6IGk5dfNg6p9XSvZPTeUJHk8iQ=;
 b=G03gADzwfGRenrT8dFA0l2VmOREmlXjdG74vu4Fq3k1Hi0GKB4v+Yo0OCpL0/LREIIRK
 yW5VuvjYGg5HK85nif3NorlRM21NA/ti+hFEipEivbFulRQ9Wjbr9kqqmvdI/ujVwFFA
 zqOVSaP1pXfhPWrw8yPRKP2rCFzDjdytH7N+cVQENYZVPyNvdyntzBR6p9AZyq7t8FzR
 RM3bE6iol5VL3Yk2ZRC9z0j7r3c48Rkl+JS+t4SzPsQ+bAA55UgO483aSr2sA7XbQTJb
 tya1bTQBJ+dtoPhiJhK5xlvkltjhuJc0jY1HtbZbt2TVFrsAlu0A5keE+JVo1S85uzT/ ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 34t7vn1u99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Nov 2020 10:52:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHAjajW150840;
 Tue, 17 Nov 2020 10:50:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3030.oracle.com with ESMTP id 34uspt77s7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Nov 2020 10:50:50 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AHAnRlt160283;
 Tue, 17 Nov 2020 10:50:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 34uspt77r2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Nov 2020 10:50:49 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AHAoiFu027667;
 Tue, 17 Nov 2020 10:50:44 GMT
Received: from [10.159.144.149] (/10.159.144.149)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 17 Nov 2020 02:50:43 -0800
Subject: Re: remove dma_virt_ops v2
To: santosh.shilimkar@oracle.com, Jason Gunthorpe <jgg@ziepe.ca>
References: <20201106181941.1878556-1-hch@lst.de>
 <20201112094030.GA19550@lst.de> <20201112132353.GQ244516@ziepe.ca>
 <2f644747-4a4f-7e03-d857-c2d7879054dd@oracle.com>
From: Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <6da0d3b0-2db7-4c7e-145a-8f76733e9978@oracle.com>
Date: Tue, 17 Nov 2020 18:50:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2f644747-4a4f-7e03-d857-c2d7879054dd@oracle.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170079
X-Mailman-Approved-At: Tue, 17 Nov 2020 15:30:51 +0000
Cc: rds-devel@oss.oracle.com, Zhu Yanjun <yanjunz@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>
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

T24gMTEvMTMvMjAgMTozNiBBTSwgc2FudG9zaC5zaGlsaW1rYXJAb3JhY2xlLmNvbSB3cm90ZToK
PiArIEthLUNoZW9uZwo+IAo+IE9uIDExLzEyLzIwIDU6MjMgQU0sIEphc29uIEd1bnRob3JwZSB3
cm90ZToKPj4gT24gVGh1LCBOb3YgMTIsIDIwMjAgYXQgMTA6NDA6MzBBTSArMDEwMCwgQ2hyaXN0
b3BoIEhlbGx3aWcgd3JvdGU6Cj4+PiBwaW5nPwo+Pj4KPj4+IE9uIEZyaSwgTm92IDA2LCAyMDIw
IGF0IDA3OjE5OjMxUE0gKzAxMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+Pj4+IEhpIEph
c29uLAo+Pj4+Cj4+Pj4gdGhpcyBzZXJpZXMgc3dpdGNoZXMgdGhlIFJETUEgY29yZSB0byBvcGVu
Y29kZSB0aGUgc3BlY2lhbCBjYXNlIG9mCj4+Pj4gZGV2aWNlcyBieXBhc3NpbmcgdGhlIERNQSBt
YXBwaW5nIGluIHRoZSBSRE1BIFVMUHMuwqAgVGhlIHZpcnQgb3BzCj4+Pj4gaGF2ZSBjYXVzZWQg
YSBiaXQgb2YgdHJvdWJsZSBkdWUgdG8gdGhlIFAyUCBjb2RlIG5vZGUgd29ya2luZyB3aXRoCj4+
Pj4gdGhlbSBkdWUgdG8gdGhlIGZhY3QgdGhhdCB3ZSdkIGRvIHR3byBkbWEgbWFwcGluZyBpdGVy
YXRpb25zIGZvciBhCj4+Pj4gc2luZ2xlIEkvTywgYnV0IGFsc28gYXJlIGEgYml0IG9mIGxheWVy
aW5nIHZpb2xhdGlvbiBhbmQgbGVhZCB0bwo+Pj4+IG1vcmUgY29kZSB0aGFuIG5lY2Vzc2FyeS4K
Pj4+Pgo+Pj4+IFRlc3RlZCB3aXRoIG52bWUtcmRtYSBvdmVyIHJ4ZS4KPj4+Pgo+Pj4+IE5vdGUg
dGhhdCB0aGUgcmRzIGNoYW5nZXMgYXJlIHVudGVzdGVkLCBhcyBJIGNvdWxkIG5vdCBmaW5kIGFu
eQo+Pj4+IHNpbXBsZSByZHMgdGVzdCBzZXR1cC4KPj4+Pgo+Pj4+IENoYW5nZXMgc2luY2UgdjI6
Cj4+Pj4gwqAgLSBzaW1wbGlmeSB0aGUgSU5GSU5JQkFORF9WSVJUX0RNQSBkZXBlbmRlbmNpZXMK
Pj4+PiDCoCAtIGFkZCBhIGliX3VzZXNfdmlydF9kbWEgaGVscGVyCj4+Pj4gwqAgLSB1c2UgaWJf
dXNlc192aXJ0X2RtYSBpbiBudm1ldC1yZG1hIHRvIGRpc2FibGUgcDJwIGZvciB2aXJ0X2RtYSBk
ZXZpY2VzCj4+Pj4gwqAgLSB1c2UgaWJfZG1hX21heF9zZWdfc2l6ZSBpbiB1bWVtCj4+Pj4gwqAg
LSBzdG9wIHVzaW5nIGRtYXBvb2wgaW4gcmRzCj4+Pj4KPj4+PiBDaGFuZ2VzIHNpbmNlIHYxOgo+
Pj4+IMKgIC0gZGlzYWJsZSBzb2Z0d2FyZSBSRE1BIGRyaXZlcnMgZm9yIGhpZ2htZW0gY29uZmln
cwo+Pj4+IMKgIC0gdXBkYXRlIHRoZSBQQ0kgY29tbWl0IGxvZ3MKPj4KPj4gU2FudG9zaCBjYW4g
eW91IHBsZWFzZSBjaGVjayB0aGUgUkRBIHBhcnRzPz8KPj4KPiAKPiBIaSBLYS1DaGVvbmcsCj4g
Cj4gQ2FuIHlvdSBwbGVhc2UgY2hlY2sgQ2hyaXN0b3BoIGNoYW5nZSBbMV0gd2hpY2ggY2xlYW4t
dXAKPiBkbWEtcG9vbCBBUEkgdG8gdXNlIGliX2RtYV8qIGFuZCBzbGFiIGFsbG9jYXRvciA/IFRo
aXMgd2FzIGFkZGVkCj4gYXMgcGFydCBvZiB5b3VyICJuZXQvcmRzOiBVc2UgRE1BIG1lbW9yeSBw
b29sIGFsbG9jYXRpb24gZm9yIHJkc19oZWFkZXIiCj4gY29tbWl0LgoKCkkgYXBwbGllZCB0aGUg
cGF0Y2ggYW5kIHJhbiBzb21lIGJhc2ljIHRlc3RpbmcuICBBbmQgaXQgc2VlbXMgdG8Kd29yayBm
aW5lLgoKVGhhbmtzLgoKCi0tIApLLiBQb29uCmthLWNoZW9uZy5wb29uQG9yYWNsZS5jb20KCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
