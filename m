Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B942FC83000
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 18:37:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81737208E0
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 18:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yCx7580v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81737208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 387E6875E9;
	Tue, 28 Apr 2020 18:37:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D-36LN+4WZnf; Tue, 28 Apr 2020 18:37:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5B61E875D7;
	Tue, 28 Apr 2020 18:37:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BBF5C0864;
	Tue, 28 Apr 2020 18:37:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AF9BC0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 18:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2C588875D7
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 18:37:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Ej8n97KUUFR for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 18:37:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6981184EED
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 18:37:41 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SIZxks071067;
 Tue, 28 Apr 2020 18:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=74BgaBiqTi1MFfdeF1NQG8LUiYgFzHAykVzSoYx6QBg=;
 b=yCx7580ve6ar3ZE9++qy042uW6rV/MJ7ZA6jH372uOrQnI/ynkqq5kpzKX9q1nMQjGA4
 1/J0DvI0bTa87AxpD4bFmQXx9l1ny95pcnxYwE+MqQ/af+URHBHXVif0EyPgypBXrqJN
 HCrs325cPsfx0lzMQZHwZO7ZbtnBQJOhp+BPgthX7abDl5jbWxINARX8OXW66hAf/sWi
 zjww8/j3mcP14IY0op6WGYB17RPfaHZ7IRrT5ZsIpR7hn2jJiXXW4yQWiTz21fDLs4Bd
 /apyl5GHq8msghEv+Hycd9JlPE2tTwL/P8EYKyNLJUY5Ve0XPtCBSDjIgm+vZ/tzZECJ 1g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 30p01nr8kb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2020 18:37:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SIWCwQ019256;
 Tue, 28 Apr 2020 18:37:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 30mxx0fanf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2020 18:37:39 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SIbbGw026927;
 Tue, 28 Apr 2020 18:37:37 GMT
Received: from [10.159.229.42] (/10.159.229.42)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 28 Apr 2020 11:37:37 -0700
Subject: Re: [PATCH] xen/swiotlb: correct the check for
 xen_destroy_contiguous_region
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
References: <1588059225-11245-1-git-send-email-peng.fan@nxp.com>
 <1c01e97a-adcd-a703-55b5-8975b4ce4d2c@suse.com>
 <DB6PR0402MB2760A05135338B0CBB28123488AC0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <dba804ea-4268-24ff-7447-ddef00e9e20c@suse.com>
 <20200428172514.GA24178@char.us.oracle.com>
From: Joe Jin <joe.jin@oracle.com>
Message-ID: <bbd41468-9d58-0ff9-3c31-ff53dbe375af@oracle.com>
Date: Tue, 28 Apr 2020 11:37:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428172514.GA24178@char.us.oracle.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0
 suspectscore=2 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 clxscore=1011
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=2 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280146
Cc: Peng Fan <peng.fan@nxp.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gNC8yOC8yMCAxMDoyNSBBTSwgS29ucmFkIFJ6ZXN6dXRlayBXaWxrIHdyb3RlOgo+IE9uIFR1
ZSwgQXByIDI4LCAyMDIwIGF0IDEyOjE5OjQxUE0gKzAyMDAsIErDvHJnZW4gR3Jvw58gd3JvdGU6
Cj4+IE9uIDI4LjA0LjIwIDEwOjI1LCBQZW5nIEZhbiB3cm90ZToKPiAKPiBBZGRpbmcgSm9lIEpp
bi4KPiAKPiBKb2UsIGRpZG4ndCB5b3UgaGF2ZSBzb21lIGlkZWFzIG9uIGhvdyB0aGlzIGNvdWxk
IGJlIGltcGxlbWVudGVkPwo+IAo+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHhlbi9zd2lvdGxi
OiBjb3JyZWN0IHRoZSBjaGVjayBmb3IKPj4+PiB4ZW5fZGVzdHJveV9jb250aWd1b3VzX3JlZ2lv
bgo+Pj4+Cj4+Pj4gT24gMjguMDQuMjAgMDk6MzMsIHBlbmcuZmFuQG54cC5jb20gd3JvdGU6Cj4+
Pj4+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPgo+Pj4+Pgo+Pj4+PiBXaGVuIGJv
b3RpbmcgeGVuIG9uIGkuTVg4UU0sIG1ldDoKPj4+Pj4gIgo+Pj4+PiBbICAgIDMuNjAyMTI4XSBV
bmFibGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MK
Pj4+PiAwMDAwMDAwMDAwMjcyZDQwCj4+Pj4+IFsgICAgMy42MTA4MDRdIE1lbSBhYm9ydCBpbmZv
Ogo+Pj4+PiBbICAgIDMuNjEzOTA1XSAgIEVTUiA9IDB4OTYwMDAwMDQKPj4+Pj4gWyAgICAzLjYx
NzMzMl0gICBFQyA9IDB4MjU6IERBQlQgKGN1cnJlbnQgRUwpLCBJTCA9IDMyIGJpdHMKPj4+Pj4g
WyAgICAzLjYyMzIxMV0gICBTRVQgPSAwLCBGblYgPSAwCj4+Pj4+IFsgICAgMy42MjY2MjhdICAg
RUEgPSAwLCBTMVBUVyA9IDAKPj4+Pj4gWyAgICAzLjYzMDEyOF0gRGF0YSBhYm9ydCBpbmZvOgo+
Pj4+PiBbICAgIDMuNjMzMzYyXSAgIElTViA9IDAsIElTUyA9IDB4MDAwMDAwMDQKPj4+Pj4gWyAg
ICAzLjYzNzYzMF0gICBDTSA9IDAsIFduUiA9IDAKPj4+Pj4gWyAgICAzLjY0MDk1NV0gWzAwMDAw
MDAwMDAyNzJkNDBdIHVzZXIgYWRkcmVzcyBidXQgYWN0aXZlX21tIGlzCj4+Pj4gc3dhcHBlcgo+
Pj4+PiBbICAgIDMuNjQ3OTgzXSBJbnRlcm5hbCBlcnJvcjogT29wczogOTYwMDAwMDQgWyMxXSBQ
UkVFTVBUIFNNUAo+Pj4+PiBbICAgIDMuNjU0MTM3XSBNb2R1bGVzIGxpbmtlZCBpbjoKPj4+Pj4g
WyAgICAzLjY3NzI4NV0gSGFyZHdhcmUgbmFtZTogRnJlZXNjYWxlIGkuTVg4UU0gTUVLIChEVCkK
Pj4+Pj4gWyAgICAzLjY3NzMwMl0gV29ya3F1ZXVlOiBldmVudHMgZGVmZXJyZWRfcHJvYmVfd29y
a19mdW5jCj4+Pj4+IFsgICAgMy42ODQyNTNdIGlteDZxLXBjaWUgNWYwMDAwMDAucGNpZTogUENJ
IGhvc3QgYnJpZGdlIHRvIGJ1cyAwMDAwOjAwCj4+Pj4+IFsgICAgMy42ODgyOTddIHBzdGF0ZTog
NjAwMDAwMDUgKG5aQ3YgZGFpZiAtUEFOIC1VQU8pCj4+Pj4+IFsgICAgMy42ODgzMTBdIHBjIDog
eGVuX3N3aW90bGJfZnJlZV9jb2hlcmVudCsweDE4MC8weDFjMAo+Pj4+PiBbICAgIDMuNjkzOTkz
XSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtidXMgMDAtZmZdCj4+Pj4+IFsg
ICAgMy43MDEwMDJdIGxyIDogeGVuX3N3aW90bGJfZnJlZV9jb2hlcmVudCsweDQ0LzB4MWMwCj4+
Pj4+ICIKPj4+Pj4KPj4+Pj4gSW4geGVuX3N3aW90bGJfYWxsb2NfY29oZXJlbnQsIGlmICEoZGV2
X2FkZHIgKyBzaXplIC0gMSA8PSBkbWFfbWFzaykKPj4+Pj4gb3IgcmFuZ2Vfc3RyYWRkbGVzX3Bh
Z2VfYm91bmRhcnkocGh5cywgc2l6ZSkgYXJlIHRydWUsIGl0IHdpbGwgY3JlYXRlCj4+Pj4+IGNv
bnRpZ3VvdXMgcmVnaW9uLiBTbyB3aGVuIGZyZWUsIHdlIG5lZWQgdG8gZnJlZSBjb250aWd1b3Vz
IHJlZ2lvbiB1c2UKPj4+Pj4gdXBwZXIgY2hlY2sgY29uZGl0aW9uLgo+Pj4+Cj4+Pj4gTm8sIHRo
aXMgd2lsbCBicmVhayBQViBndWVzdHMgb24geDg2Lgo+Pj4KPj4+IENvdWxkIHlvdSBzaGFyZSBt
b3JlIGRldGFpbHMgd2h5IGFsbG9jIGFuZCBmcmVlIG5vdCBtYXRjaGluZyBmb3IgdGhlIGNoZWNr
Pwo+Pgo+PiB4ZW5fY3JlYXRlX2NvbnRpZ3VvdXNfcmVnaW9uKCkgaXMgbmVlZGVkIG9ubHkgaW4g
Y2FzZToKPj4KPj4gLSB0aGUgYnVzIGFkZHJlc3MgaXMgbm90IHdpdGhpbiBkbWFfbWFzaywgb3IK
Pj4gLSB0aGUgbWVtb3J5IHJlZ2lvbiBpcyBub3QgcGh5c2ljYWxseSBjb250aWd1b3VzIChjYW4g
aGFwcGVuIG9ubHkgZm9yCj4+ICAgUFYgZ3Vlc3RzKQo+Pgo+PiBJbiBhbnkgY2FzZSBpdCBzaG91
bGQgYXJyYW5nZSBmb3IgdGhlIG1lbW9yeSB0byBiZSBzdWl0YWJsZSBmb3IgdGhlCj4+IERNQSBv
cGVyYXRpb24sIHNvIHRvIGJlIGNvbnRpZ3VvdXMgYW5kIHdpdGhpbiBkbWFfbWFzayBhZnRlcndh
cmRzLiBTbwo+PiB4ZW5fZGVzdHJveV9jb250aWd1b3VzX3JlZ2lvbigpIHNob3VsZCBvbmx5IGV2
ZXIgY2FsbGVkIGZvciBhcmVhcwo+PiB3aGljaCBtYXRjaCBhYm92ZSBjcml0ZXJpYSwgYXMgb3Ro
ZXJ3aXNlIHdlIGNhbiBiZSBzdXJlCj4+IHhlbl9jcmVhdGVfY29udGlndW91c19yZWdpb24oKSB3
YXMgbm90IHVzZWQgZm9yIG1ha2luZyB0aGUgYXJlYSBETUEtYWJsZQo+PiBpbiB0aGUgYmVnaW5u
aW5nLgoKSSBhZ3JlZWQgd2l0aCBKdWVyZ2VuJ3MgZXhwbGFuYXRpb24sIFRoYXQgaXMgbXkgdW5k
ZXJzdGFuZGluZy4KClBlbmcsIGlmIHBhbmljIGNhdXNlZCBieSAoZGV2X2FkZHIgKyBzaXplIC0g
MSA+IGRtYV9tYXNrKSwgeW91IHNob3VsZCBjaGVjawpob3cgeW91IGdldCB0aGUgYWRkciwgaWYg
bWVtb3J5IGNyZWF0ZWQgYnkgeGVuX2NyZWF0ZV9jb250aWd1b3VzX3JlZ2lvbigpLAptZW1vcnkg
bXVzdCBiZSB3aXRoIGluIFswIC0gZG1hX21hc2tdLgoKVGhhbmtzLApKb2UKCj4+Cj4+IEFuZCB0
aGlzIGlzIHZlcnkgaW1wb3J0YW50IGluIHRoZSBQViBjYXNlLCBhcyBpbiB0aG9zZSBndWVzdHMg
dGhlIHBhZ2UKPj4gdGFibGVzIGFyZSBjb250YWluaW5nIHRoZSBob3N0LVBGTnMsIG5vdCB0aGUg
Z3Vlc3QtUEZOUywgYW5kCj4+IHhlbl9jcmVhdGVfY29udGlndW91c19yZWdpb24oKSB3aWxsIGZp
ZGRsZSB3aXRoIGhvc3QtIHZzLiBndWVzdC1QRk4KPj4gYXJyYW5nZW1lbnRzLCBhbmQgeGVuX2Rl
c3Ryb3lfY29udGlndW91c19yZWdpb24oKSBpcyByZXZlcnRpbmcgdGhpcwo+PiBmaWRkbGluZy4g
QW55IGNhbGwgb2YgeGVuX2Rlc3Ryb3lfY29udGlndW91c19yZWdpb24oKSBmb3IgYW4gYXJlYSBp
dAo+PiB3YXMgbm90IGludGVuZGVkIHRvIGJlIGNhbGxlZCBmb3IgbWlnaHQgc3dhcCBwaHlzaWNh
bCBwYWdlcyBiZW5lYXRoCj4+IHJhbmRvbSB2aXJ0dWFsIGFkZHJlc3Nlcywgd2hpY2ggd2FzIHRo
ZSByZWFzb24gZm9yIHRoaXMgdGVzdCB0byBiZQo+PiBhZGRlZCBieSBtZS4KPj4KPj4KPj4gSnVl
cmdlbgo+Pgo+Pj4KPj4+IFRoYW5rcywKPj4+IFBlbmcuCj4+Pgo+Pj4+Cj4+Pj4gSSB0aGluayB0
aGVyZSBpcyBzb21ldGhpbmcgd3Jvbmcgd2l0aCB5b3VyIHNldHVwIGluIGNvbWJpbmF0aW9uIHdp
dGggdGhlIEFSTQo+Pj4+IHhlbl9jcmVhdGVfY29udGlndW91c19yZWdpb24oKSBpbXBsZW1lbnRh
dGlvbi4KPj4+Pgo+Pj4+IFN0ZWZhbm8/Cj4+Pj4KPj4+Pgo+Pj4+IEp1ZXJnZW4KPj4+Pgo+Pj4+
Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4KPj4+Pj4g
LS0tCj4+Pj4+ICAgIGRyaXZlcnMveGVuL3N3aW90bGIteGVuLmMgfCA0ICsrLS0KPj4+Pj4gICAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Pj4KPj4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL3N3aW90bGIteGVuLmMgYi9kcml2ZXJzL3hlbi9z
d2lvdGxiLXhlbi5jCj4+Pj4+IGluZGV4IGI2ZDI3NzYyYzZmOC4uYWI5NmU0Njg1ODRmIDEwMDY0
NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL3hlbi9zd2lvdGxiLXhlbi5jCj4+Pj4+ICsrKyBiL2RyaXZl
cnMveGVuL3N3aW90bGIteGVuLmMKPj4+Pj4gQEAgLTM0Niw4ICszNDYsOCBAQCB4ZW5fc3dpb3Rs
Yl9mcmVlX2NvaGVyZW50KHN0cnVjdCBkZXZpY2UgKmh3ZGV2LAo+Pj4+IHNpemVfdCBzaXplLCB2
b2lkICp2YWRkciwKPj4+Pj4gICAgCS8qIENvbnZlcnQgdGhlIHNpemUgdG8gYWN0dWFsbHkgYWxs
b2NhdGVkLiAqLwo+Pj4+PiAgICAJc2l6ZSA9IDFVTCA8PCAob3JkZXIgKyBYRU5fUEFHRV9TSElG
VCk7Cj4+Pj4+Cj4+Pj4+IC0JaWYgKCFXQVJOX09OKChkZXZfYWRkciArIHNpemUgLSAxID4gZG1h
X21hc2spIHx8Cj4+Pj4+IC0JCSAgICAgcmFuZ2Vfc3RyYWRkbGVzX3BhZ2VfYm91bmRhcnkocGh5
cywgc2l6ZSkpICYmCj4+Pj4+ICsJaWYgKCgoZGV2X2FkZHIgKyBzaXplIC0gMSA+IGRtYV9tYXNr
KSB8fAo+Pj4+PiArCSAgICByYW5nZV9zdHJhZGRsZXNfcGFnZV9ib3VuZGFyeShwaHlzLCBzaXpl
KSkgJiYKPj4+Pj4gICAgCSAgICBUZXN0Q2xlYXJQYWdlWGVuUmVtYXBwZWQodmlydF90b19wYWdl
KHZhZGRyKSkpCj4+Pj4+ICAgIAkJeGVuX2Rlc3Ryb3lfY29udGlndW91c19yZWdpb24ocGh5cywg
b3JkZXIpOwo+Pj4+Pgo+Pj4+Pgo+Pj4KPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
