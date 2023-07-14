Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CC110F4
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 02:57:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4s9Udj+uXdYgqYU9AbIWYgFSY8BaTQlCDnJ44jZLqiQcZcA66WyZ9AipFU6kKEL8JwJ3ELEV8UQ5skVFvH3oHBPbaZgBP3D1PorLQDN07Q+Ywm7ETy19WodZsYFfw/2z7cXQI0WEVUX6eQk959gV+RAPzcdkx+wKKmnZzBG/uJ4gIl1KAOOYsJhmh6JPX2HyYJQAtfNL2VbsyOcfYkMpfCmR3jDNuamsdJYAsEpPXnMhdp2Qz+ARBuwwKanxUoVYZo2v6pOAzfDEZ+TkzRue1iIe9x2MKiIVjNh05Y0gwi/XSjRjSJHskA8BQVj+H+Lbv3YaEHRDSeRqFQkqLjq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3Oa8RBusm24D89MCRw6Cbv5y/J3wFgTIs6w5TSSah8=;
 b=IHCDOdoyownNunAgxhIg8/xDCQKXNRqhJrvTbrHiln3jvRyUhBLF13lmuA1RqAlN1W4Jfa9YzTZRD9CKoTni9V6Ztkc2iUo40gb7atH9Q3TLGgt8F1wdDpMV88nXooWp1NGfNoTecs+7FRjHPbztAVbzhXR+cM8yoHd6nyFmoSTpkLq8YN+eLY8+LwnTIMVa0LOHeBxt3hWjFljekHY4r1S7ngl8Ge69J3/WMwnxTEQwauQOSkbmLXNUQsK/TOe6XoholBH8nbzDEbl4ZKjJsNQ0Ueecza8j2vmNqpeL5+qc9xgYUsqsc4jMBcjVQe36TkA/eREv5CGwAYablwt7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3Oa8RBusm24D89MCRw6Cbv5y/J3wFgTIs6w5TSSah8=;
 b=bATzdseXqjfFpGJZbAxF3JxsN/sgtq9hyC4KSHXzHr20mDfJEO+k5W5bni1oQwIjEFIfAGU6sgV7r+txoFnxl3NzR6Wuy9232jHFELVvBkmNhuIa82376ZkNxxsSlmHXuz/vaZM3GRZhS8+4Oj6UST6WHKcTB2JlarGPA2R8MNmzJP3Ov/mq0dm4SE34iD/ntbWPFm9OFfl1vWTq6tfDCNovLDF1qykfucCY7G4k5ugYJO5l+w0sYFGACBDR/uw//PRQr0NIZvRPS92+ZvHe0sZyb+DZDbs4iqk11VXPO7WRhgw7i7DiDDOlXHnShPrNlEqe4pJIU1hQfQXy3Wf7zQ==
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYZPR06MB4110.apcprd06.prod.outlook.com (2603:1096:400:2b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.22; Fri, 14 Jul 2023 02:57:37 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Fri, 14 Jul 2023
 02:57:36 +0000
From: =?utf-8?B?5p2c5pWP5p2w?= <duminjie@vivo.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Thierry Reding
	<thierry.reding@gmail.com>, Krishna Reddy <vdumpa@nvidia.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, "open
 list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>, "open list:IOMMU
 SUBSYSTEM" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
CC: opensource.kernel <opensource.kernel@vivo.com>, Thierry Reding
	<treding@nvidia.com>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2NF0gaW9tbXU6IHJlbW92ZSByZWR1?=
 =?utf-8?B?bmRhbnQgcGFyYW1ldGVyIGNoZWNrIGluIHRlZ3JhX3NtbXVfZGVidWdmc19p?=
 =?utf-8?Q?nit()?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjRdIGlvbW11OiByZW1vdmUgcmVkdW5kYW50IHBh?=
 =?utf-8?B?cmFtZXRlciBjaGVjayBpbiB0ZWdyYV9zbW11X2RlYnVnZnNfaW5pdCgp?=
Thread-Index: AQHZtVulTt9Be4N5d0ejJ/S/NfzgtK+4i9sAgAAAf/CAAAT1gIAAAK+A
Date: Fri, 14 Jul 2023 02:57:36 +0000
Message-ID:
 <SG2PR06MB5288129B8706875F886FAEF3AE34A@SG2PR06MB5288.apcprd06.prod.outlook.com>
References: <20230713072825.10348-1-duminjie@vivo.com>
 <61f31b3e-b618-88db-a07c-f6761c1c7d06@linux.intel.com>
 <SG2PR06MB5288E9FC9B6EA21E20BB011EAE34A@SG2PR06MB5288.apcprd06.prod.outlook.com>
 <ed4200bb-d7e8-b8b5-bfb6-510bebbb8808@linux.intel.com>
In-Reply-To: <ed4200bb-d7e8-b8b5-bfb6-510bebbb8808@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB5288:EE_|TYZPR06MB4110:EE_
x-ms-office365-filtering-correlation-id: 607e73c2-8d16-45e3-620a-08db84161468
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8Ol9424+6JKhkfgMdcccfnio3zMBdq5oTLivDhoP4wdXYDnvLnFHiCHS1f4UnpBmt8+XuFdKjb0LZ+2vQXGpb1FwHziNe15OPotV80HtKrIdSVaqjSyFNiEAzHoPmamuPObmLRpYHH4v4rm/e5cjCTmXpNHFf3P5/9cA9Ui3pVnACoF6T76Np9zk+HeNNjE5oWTbI7gu+MzPpDjJ3BIW7/3VahNe9B87UDEaeo50g0qPR7ytBuDekljXg9qrMe2vPsm3m7j5VaM3KdYNqKT6LP45twCS5CPswlUaKrIMd+NxeDi6977ywtqBSPnx6EoOA5RgyQZzF/Y50yd1u/xf6p2k8xuF5ToKX/oEERKGcNevDQl+87ux8GGS5AIBugF6l6xAkL1X40en1s8xnqZl3QDFSRiqe0bdgZ4FHu9XX4SYXAqNryuxqxImdqg7EiieEmJoshrKcwMkZD+L7nzkIeJafbaSjxqODe9sYxlJa7ME7Xbzg+0q9abIuoSbG4TglxNys86uN2BOzXfBOrggpHIhQR0v+C/JxdlN67MAxSEJ3s8VD+LicopvQWIfR1r13rPohBFwP9vuiXFE6nECjrlcTbMmsSDmfFRLbYsjWU0p9lXU+Xx7zdR8Q+r60JZ47ATgK5+DnD5W3PuXsmFzpg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(136003)(396003)(346002)(376002)(451199021)(478600001)(122000001)(110136005)(54906003)(71200400001)(7696005)(66476007)(66556008)(66946007)(64756008)(66446008)(76116006)(4326008)(316002)(9686003)(966005)(41300700001)(921005)(186003)(2906002)(4744005)(55016003)(53546011)(8936002)(38100700002)(6506007)(85182001)(26005)(52536014)(5660300002)(7416002)(86362001)(33656002)(38070700005)(224303003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QjZubUw4N2tVWHM1Yk9GY3hPRDRwNDZEREZBZ3U1L3pmL0Y3R2Iwd3ZNc1B6?=
 =?utf-8?B?djh4TlpNUXZsd05OTm01NjQ0UzRyRjZiL0RWaFFMbEhGRTduRzdZMHkxSUJ0?=
 =?utf-8?B?L0JzSDNoRFZnQUpKY3BlMWt2NDFVRUVvYy84Y2gydHZybGpiVTI3ZjE5WTEv?=
 =?utf-8?B?UUxSKy8wbitxRE1XZTNkeDZ2eEh6dStYU2dEUys2Vnc5SVl2c0ZtSU1PSEtF?=
 =?utf-8?B?RXVWMDgwandwZ3F0aXhnZXQwN1Y3QzZVN0ZPZEJGcXl3dEcwc0piRThGL1VZ?=
 =?utf-8?B?ak9rbU00WkRNSzZYT2x2YTZEUkFmKzRzSDNtdWVmdlBCOFlQUkhJaDQySjQ1?=
 =?utf-8?B?bFhTVHhUa0wxSk8zanZKY2lweld0NExGYUNwSDNuVlJXVUg4RWJtV3AyY3JJ?=
 =?utf-8?B?MjJkNzVyMGNmdEtPTkpjVnc1Z0RoK0pVNnI3Lzh6d0RETFUrN2gvOThqRnNM?=
 =?utf-8?B?TDdVdVdvZGxXUDA1QmFXVVVUME5Cb25IS2FSY3JIV2s3ZU11ODNyVjVpc2Zu?=
 =?utf-8?B?SHVxQXpWc2hmUStEdkRKeGxPTlNCQUFsNUx1ZW9lWU9mN1BFdDR5akZ1OEs2?=
 =?utf-8?B?Z3B4TDY5dHZycnU1akFINU8xL2VybThDalRwTEE1NmQ1OHZ2K2xIWW0wVTNz?=
 =?utf-8?B?MW40RmU5aFlnY1dtbEJKUzhYUWQ2amNLWmtJRkxsdzNzZ1FkdjhOa3hBbmp1?=
 =?utf-8?B?WmErVm9heDBKM1IxY3BaRnlzZHB1Y0FpbGJ6RFBnVEJxUTFwbG1GR3JOelVL?=
 =?utf-8?B?N21zMEp4YkR1VXJnU1VLSlVSN0lSSnBWaHU3V1U1aUk0bUZ5TUQ0YWk5R1hy?=
 =?utf-8?B?MVBJd3NSVm01SUtkRG5lWHkvYUZrSXZzQndubmNkejY5MTREOGVPNDdLZlVw?=
 =?utf-8?B?U0RUK3NTSENTWWs4dlRFY0VySktpV2JwcnE3M1pMR1FpOHNIeGRLZVdkVUly?=
 =?utf-8?B?Mm5QNkdlWVJESmQvcXFRN21BcUo2aEc4SjlaRjFVQVRtRXdMK1FLYXppK3BL?=
 =?utf-8?B?aXlWZ1YzVXFJYnIyQ25YNXZQZTVielZONkZJeWNCdXpZT0lPM2VxckIxeTM3?=
 =?utf-8?B?YndvbnRUYnBvd1N4Wm9nVlQ3TXdMVVBCSHhpbTNlS0xEclZGY1F4eHlhSnFF?=
 =?utf-8?B?U0l4dWVwd1BGSjdDUzd3RDc4UXpFbksyeEdTWllHdk9pcGNrYlNZZ2tuWmc3?=
 =?utf-8?B?K0w3VjlhZytBcW5Celc3cjBSRDFkNE9vQnphY0FwRDdGT3RCcGFKY0kwRmdo?=
 =?utf-8?B?NnNRVytWR1l4TlFqK2hQYmFESzl0cEswYzY2RnJQcHZEOEZ3bjBYemJJSlVw?=
 =?utf-8?B?bTJpYXcvNkZJdlFKd2crVnZSK3VwK2xFY2NZbXlGcFE0M1B5K0w0dnAwZzF6?=
 =?utf-8?B?bVVtSFFJSmk0MkltNWFvZktUUnVVeHl6VDh1T1lza3hyQ0h0Z2JOYk9JMksx?=
 =?utf-8?B?dmhwMmNGYUEyekl2MVBIaFNLaXd3cldXQ05yZFVVc05RNXRQZ3BzL2F4eUhX?=
 =?utf-8?B?azBRQStTSFo0TlZ2c3FZY0VacUd2SVVPcVdGVWxXWFR0Y3VtdUR2NVRRRVdW?=
 =?utf-8?B?R2c2YTFmVXFyTU9XbHFqV0huYWxZTDA4bDI3T2ZxOGdtZjZrbVBrdlBDTElr?=
 =?utf-8?B?OGJCUDB5ZnJEUkxFTmZMYlc2ekRlTjkrM0xpOHJrRXg4R0FKN1AxTmsrSmVJ?=
 =?utf-8?B?QUcvcm9xdzlKRHJLZURMSUVtTnA2TmREMFVOK2E2Qm1WQzBQYnAwNzNtSDZY?=
 =?utf-8?B?aGZZTm9mNVFzcTd3ZGo1b01JRVhOeit6SG5qYlN0c2FpODN1eHQvYVlRcmov?=
 =?utf-8?B?MDdWRmdmY3NOT0JMVkxXNkNIdTRFQUpTK3BrLzZSVmJGMGdZSm84M2R6ZjZh?=
 =?utf-8?B?aW5GZGpCZGZ4bi95d3ZFRm80S2tUcE9wR3M3dmpUWGRxN0JPTG9kSjJwRjRn?=
 =?utf-8?B?VTYvL3NMZjc5c2JXZTZZL0p2d2hISHJGL1BwMmhIQlg4TGJxT2x2eGVoS3I3?=
 =?utf-8?B?TXFmcGZYN21QdTNKUkdCMEFZeHlpYXJGdmdMTi83ZWgzZVlTK0FCSTJOdisr?=
 =?utf-8?B?NDN5V0F3YWV6VzhBdTN6cnNSSEFnZUdLN1hQckE1YWt5SUZXMjRjb3RGdllL?=
 =?utf-8?Q?RERD6OiKYYVUHpBr4XVYFaMia?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607e73c2-8d16-45e3-620a-08db84161468
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 02:57:36.6249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvTRbXjDWgrcYYcX5T9u877cuTNpKQ1Gx5/xmA4cCBEkunsrOTJZXNo37aMd8tCkgvVV+uN11aeBcgWKhKBAAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4110

SGkgQmFvbHUhDQoNCkkgd2lsbCBwYXkgYXR0ZW50aW9uIHRvIHRoaXMgaW4gZnV0dXJlIHBhdGNo
IQ0KVGhhbmtzIGFnYWluIQ0KDQpyZWdhcmRzLA0KTWluamllDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2
LS0tLS0NCuWPkeS7tuS6ujogQmFvbHUgTHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4gDQrl
j5HpgIHml7bpl7Q6IDIwMjPlubQ35pyIMTTml6UgMTA6NTENCuaUtuS7tuS6ujog5p2c5pWP5p2w
IDxkdW1pbmppZUB2aXZvLmNvbT47IFRoaWVycnkgUmVkaW5nIDx0aGllcnJ5LnJlZGluZ0BnbWFp
bC5jb20+OyBLcmlzaG5hIFJlZGR5IDx2ZHVtcGFAbnZpZGlhLmNvbT47IEpvZXJnIFJvZWRlbCA8
am9yb0A4Ynl0ZXMub3JnPjsgV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz47IFJvYmluIE11
cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+OyBKb25hdGhhbiBIdW50ZXIgPGpvbmF0aGFuaEBu
dmlkaWEuY29tPjsgb3BlbiBsaXN0OlRFR1JBIElPTU1VIERSSVZFUlMgPGxpbnV4LXRlZ3JhQHZn
ZXIua2VybmVsLm9yZz47IG9wZW4gbGlzdDpJT01NVSBTVUJTWVNURU0gPGlvbW11QGxpc3RzLmxp
bnV4LmRldj47IG9wZW4gbGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCuaKhOmA
gTogYmFvbHUubHVAbGludXguaW50ZWwuY29tOyBvcGVuc291cmNlLmtlcm5lbCA8b3BlbnNvdXJj
ZS5rZXJuZWxAdml2by5jb20+OyBUaGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPg0K
5Li76aKYOiBSZTog5Zue5aSNOiBbUEFUQ0ggdjRdIGlvbW11OiByZW1vdmUgcmVkdW5kYW50IHBh
cmFtZXRlciBjaGVjayBpbiB0ZWdyYV9zbW11X2RlYnVnZnNfaW5pdCgpDQoNCltZb3UgZG9uJ3Qg
b2Z0ZW4gZ2V0IGVtYWlsIGZyb20gYmFvbHUubHVAbGludXguaW50ZWwuY29tLiBMZWFybiB3aHkg
dGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50
aWZpY2F0aW9uIF0NCg0KT24gMjAyMy83LzE0IDEwOjM4LCDmnZzmlY/mnbAgd3JvdGU6DQo+IEhp
IGJhb2x1IQ0KPg0KPiBUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbiENCj4NCj4gWW91IHNheToN
Cj4+IE5leHQgdGltZSB3aGVuIHlvdSBzZW5kIGEgbmV3IHZlcnNpb24gb2YgYSBwYXRjaCwgcGxl
YXNlIGRvbid0IGZvcmdldCB0byBhZGQgdGhlIGNoYW5nZSBsb2cgYWZ0ZXIgdGhlIHRlYXIgbGlu
ZS4gVGhpcyB3YXksIHBlb3BsZSBjYW4ga25vdyBob3cgdGhlIHBhdGNoIGV2b2x2ZWQgaW50byB0
aGlzIHdheS4NCj4gRG8gSSBuZWVkIHRvIHN1Ym1pdCBhIG5ldyBwYXRjaD8NCg0KT2ggbm8uIEp1
c3QgYSBraW5kIHJlbWluZC4gOi0pDQoNCkJlc3QgcmVnYXJkcywNCmJhb2x1DQo=
