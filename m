Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3438BC5519F
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 19:11:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C8424181
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 19:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w3gB8wAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C8424181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 18E3286246;
	Tue, 17 Nov 2020 19:11:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1cuvHEfuSlQ5; Tue, 17 Nov 2020 19:10:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BEA6286196;
	Tue, 17 Nov 2020 19:10:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3637C0891;
	Tue, 17 Nov 2020 19:10:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F969C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 19:10:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0014F20006
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 19:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vrDUQEXXl9Za for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 19:10:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by silver.osuosl.org (Postfix) with ESMTPS id D90CE1FFC1
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 19:10:55 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHJAJ4t181401;
 Tue, 17 Nov 2020 19:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SAUprEBsvlCQjFy54O1Y1idjlN/31+XevpP98p8fqMY=;
 b=w3gB8wAfcz/F94CTrwRG8znvibTdOVM0LVMqT83ZxODjtyeBYq91dhzwNAU94UDuJPd9
 bmjd/gIKnXBWSMQnj4BA5gH4MLALozd/U1gu97QxC0A38PFsBf+9SkxMlKm1CDNWXA/d
 ZJE+vOZkOc/kXqeBnLhMwRjPGmyQBw7PAUyYhWm8bWKXGjlnTgsJjX6s8BsoYApV/3ET
 dx8akrYCQxNhCc7ZJ9aZS+20vLKSxorRop8wFu5jXJbtMy72BDfxkS+t6kR5H/wAhidR
 EiEFtZ9i2XRWy7N+k1QWt1usTX4O6Z27OHhS/XDJzEx/TnINJS/4cHN4UQ/6zm6m2llM MA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 34t4ravf45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Nov 2020 19:10:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHJ1USB045244;
 Tue, 17 Nov 2020 19:10:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3020.oracle.com with ESMTP id 34ts0rakgu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Nov 2020 19:10:46 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AHJAjUX078579;
 Tue, 17 Nov 2020 19:10:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 34ts0rakg9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Nov 2020 19:10:45 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AHJAdcr017336;
 Tue, 17 Nov 2020 19:10:39 GMT
Received: from [10.98.138.20] (/10.98.138.20)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 17 Nov 2020 11:10:39 -0800
Subject: Re: remove dma_virt_ops v2
To: Ka-Cheong Poon <ka-cheong.poon@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20201106181941.1878556-1-hch@lst.de>
 <20201112094030.GA19550@lst.de> <20201112132353.GQ244516@ziepe.ca>
 <2f644747-4a4f-7e03-d857-c2d7879054dd@oracle.com>
 <6da0d3b0-2db7-4c7e-145a-8f76733e9978@oracle.com>
From: santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <f748d99e-aa4d-5f8d-debd-da2a3cd007e7@oracle.com>
Date: Tue, 17 Nov 2020 11:10:37 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <6da0d3b0-2db7-4c7e-145a-8f76733e9978@oracle.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170138
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

T24gMTEvMTcvMjAgMjo1MCBBTSwgS2EtQ2hlb25nIFBvb24gd3JvdGU6Cj4gT24gMTEvMTMvMjAg
MTozNiBBTSwgc2FudG9zaC5zaGlsaW1rYXJAb3JhY2xlLmNvbSB3cm90ZToKPj4gKyBLYS1DaGVv
bmcKPj4KPj4gT24gMTEvMTIvMjAgNToyMyBBTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+Pj4g
T24gVGh1LCBOb3YgMTIsIDIwMjAgYXQgMTA6NDA6MzBBTSArMDEwMCwgQ2hyaXN0b3BoIEhlbGx3
aWcgd3JvdGU6Cj4+Pj4gcGluZz8KPj4+Pgo+Pj4+IE9uIEZyaSwgTm92IDA2LCAyMDIwIGF0IDA3
OjE5OjMxUE0gKzAxMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+Pj4+PiBIaSBKYXNvbiwK
Pj4+Pj4KPj4+Pj4gdGhpcyBzZXJpZXMgc3dpdGNoZXMgdGhlIFJETUEgY29yZSB0byBvcGVuY29k
ZSB0aGUgc3BlY2lhbCBjYXNlIG9mCj4+Pj4+IGRldmljZXMgYnlwYXNzaW5nIHRoZSBETUEgbWFw
cGluZyBpbiB0aGUgUkRNQSBVTFBzLsKgIFRoZSB2aXJ0IG9wcwo+Pj4+PiBoYXZlIGNhdXNlZCBh
IGJpdCBvZiB0cm91YmxlIGR1ZSB0byB0aGUgUDJQIGNvZGUgbm9kZSB3b3JraW5nIHdpdGgKPj4+
Pj4gdGhlbSBkdWUgdG8gdGhlIGZhY3QgdGhhdCB3ZSdkIGRvIHR3byBkbWEgbWFwcGluZyBpdGVy
YXRpb25zIGZvciBhCj4+Pj4+IHNpbmdsZSBJL08sIGJ1dCBhbHNvIGFyZSBhIGJpdCBvZiBsYXll
cmluZyB2aW9sYXRpb24gYW5kIGxlYWQgdG8KPj4+Pj4gbW9yZSBjb2RlIHRoYW4gbmVjZXNzYXJ5
Lgo+Pj4+Pgo+Pj4+PiBUZXN0ZWQgd2l0aCBudm1lLXJkbWEgb3ZlciByeGUuCj4+Pj4+Cj4+Pj4+
IE5vdGUgdGhhdCB0aGUgcmRzIGNoYW5nZXMgYXJlIHVudGVzdGVkLCBhcyBJIGNvdWxkIG5vdCBm
aW5kIGFueQo+Pj4+PiBzaW1wbGUgcmRzIHRlc3Qgc2V0dXAuCj4+Pj4+Cj4+Pj4+IENoYW5nZXMg
c2luY2UgdjI6Cj4+Pj4+IMKgIC0gc2ltcGxpZnkgdGhlIElORklOSUJBTkRfVklSVF9ETUEgZGVw
ZW5kZW5jaWVzCj4+Pj4+IMKgIC0gYWRkIGEgaWJfdXNlc192aXJ0X2RtYSBoZWxwZXIKPj4+Pj4g
wqAgLSB1c2UgaWJfdXNlc192aXJ0X2RtYSBpbiBudm1ldC1yZG1hIHRvIGRpc2FibGUgcDJwIGZv
ciB2aXJ0X2RtYSAKPj4+Pj4gZGV2aWNlcwo+Pj4+PiDCoCAtIHVzZSBpYl9kbWFfbWF4X3NlZ19z
aXplIGluIHVtZW0KPj4+Pj4gwqAgLSBzdG9wIHVzaW5nIGRtYXBvb2wgaW4gcmRzCj4+Pj4+Cj4+
Pj4+IENoYW5nZXMgc2luY2UgdjE6Cj4+Pj4+IMKgIC0gZGlzYWJsZSBzb2Z0d2FyZSBSRE1BIGRy
aXZlcnMgZm9yIGhpZ2htZW0gY29uZmlncwo+Pj4+PiDCoCAtIHVwZGF0ZSB0aGUgUENJIGNvbW1p
dCBsb2dzCj4+Pgo+Pj4gU2FudG9zaCBjYW4geW91IHBsZWFzZSBjaGVjayB0aGUgUkRBIHBhcnRz
Pz8KPj4+Cj4+Cj4+IEhpIEthLUNoZW9uZywKPj4KPj4gQ2FuIHlvdSBwbGVhc2UgY2hlY2sgQ2hy
aXN0b3BoIGNoYW5nZSBbMV0gd2hpY2ggY2xlYW4tdXAKPj4gZG1hLXBvb2wgQVBJIHRvIHVzZSBp
Yl9kbWFfKiBhbmQgc2xhYiBhbGxvY2F0b3IgPyBUaGlzIHdhcyBhZGRlZAo+PiBhcyBwYXJ0IG9m
IHlvdXIgIm5ldC9yZHM6IFVzZSBETUEgbWVtb3J5IHBvb2wgYWxsb2NhdGlvbiBmb3IgcmRzX2hl
YWRlciIKPj4gY29tbWl0Lgo+IAo+IAo+IEkgYXBwbGllZCB0aGUgcGF0Y2ggYW5kIHJhbiBzb21l
IGJhc2ljIHRlc3RpbmcuwqAgQW5kIGl0IHNlZW1zIHRvCj4gd29yayBmaW5lLgo+IApUaGFua3Mg
S2EtQ2hlb25nLgoKSmFzb24sIEZlZWwgZnJlZSB0byBhZGQgYWNrIGZvciB0aGUgUkRTIHBhcnQu
CgpSZWdhcmRzLApTYW50b3NoCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
