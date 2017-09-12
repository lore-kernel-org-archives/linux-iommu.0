From: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: flush IOTLB for specific domains only (v3)
Date: Tue, 12 Sep 2017 14:49:40 +0800
Message-ID: <CAD8Lp47XquppriMyTfjMgw2MHUL+KNwxv0at96+kYxGH9Qjkxg@mail.gmail.com>
References: <20170407102039.GW7266@8bytes.org>
 <1495439281-24005-1-git-send-email-arindam.nath@amd.com>
 <20170529143831.GA30388@8bytes.org>
 <MWHPR12MB1518926453E8BAF205F3492D9CF00@MWHPR12MB1518.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB1518926453E8BAF205F3492D9CF00-Gy0DoCVfaSXKu+HfpMNLNQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Nath, Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>
Cc: "Lendacky, Thomas" <Thomas.Lendacky-5C7GfCeVMHo@public.gmane.org>, "Bridgman,
 John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Craig Stein <stein12c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org" <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, "michel-otUistvHUpPR7s880joybQ@public.gmane.org" <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

SGksCgpPbiBUdWUsIE1heSAzMCwgMjAxNyBhdCAzOjM4IFBNLCBOYXRoLCBBcmluZGFtIDxBcmlu
ZGFtLk5hdGhAYW1kLmNvbT4gd3JvdGU6Cj4+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj5G
cm9tOiBKb2VyZyBSb2VkZWwgW21haWx0bzpqb3JvQDhieXRlcy5vcmddCj4+U2VudDogTW9uZGF5
LCBNYXkgMjksIDIwMTcgODowOSBQTQo+PlRvOiBOYXRoLCBBcmluZGFtIDxBcmluZGFtLk5hdGhA
YW1kLmNvbT47IExlbmRhY2t5LCBUaG9tYXMKPj48VGhvbWFzLkxlbmRhY2t5QGFtZC5jb20+Cj4+
Q2M6IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsKPj5EZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBCcmlkZ21hbiwgSm9obgo+PjxKb2huLkJyaWRnbWFuQGFtZC5jb20+OyBkcmFrZUBlbmRs
ZXNzbS5jb207IFN1dGhpa3VscGFuaXQsIFN1cmF2ZWUKPj48U3VyYXZlZS5TdXRoaWt1bHBhbml0
QGFtZC5jb20+OyBsaW51eEBlbmRsZXNzbS5jb207IENyYWlnIFN0ZWluCj4+PHN0ZWluMTJjQGdt
YWlsLmNvbT47IG1pY2hlbEBkYWVuemVyLm5ldDsgS3VlaGxpbmcsIEZlbGl4Cj4+PEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+OyBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4+U3ViamVjdDogUmU6IFtQ
QVRDSF0gaW9tbXUvYW1kOiBmbHVzaCBJT1RMQiBmb3Igc3BlY2lmaWMgZG9tYWlucyBvbmx5ICh2
MykKPj4KPj5IaSBBcmluZGFtLAo+Pgo+PkkgbWV0IFRvbSBMZW5kYWNreSBsYXN0IHdlZWsgaW4g
TnVyZW1iZXJnIGxhc3Qgd2VlayBhbmQgaGUgdG9sZCBtZSBoZSBpcwo+Pndvcmtpbmcgb24gdGhl
IHNhbWUgYXJlYSBvZiB0aGUgY29kZSB0aGF0IHRoaXMgcGF0Y2ggaXMgZm9yLiBIaXMgcmVhc29u
Cj4+Zm9yIHRvdWNoaW5nIHRoaXMgY29kZSB3YXMgdG8gc29sdmUgc29tZSBsb2NraW5nIHByb2Js
ZW1zLiBNYXliZSB5b3UgdHdvCj4+Y2FuIHdvcmsgdG9nZXRoZXIgb24gYSBqb2ludCBhcHByb2Fj
aCB0byBpbXByb3ZlIHRoaXM/Cj4KPiBTdXJlIEpvZXJnLCBJIHdpbGwgd29yayB3aXRoIFRvbS4K
CldoYXQgd2FzIHRoZSBlbmQgcmVzdWx0IGhlcmU/IEkgc2VlIHRoYXQgdGhlIGNvZGUgaGFzIGJl
ZW4gcmV3b3JrZWQgaW4KNC4xMyBzbyB5b3VyIG9yaWdpbmFsIHBhdGNoIG5vIGxvbmdlciBhcHBs
aWVzLiBJcyB0aGUgcmV3b3JrZWQgdmVyc2lvbgphbHNvIGV4cGVjdGVkIHRvIHNvbHZlIHRoZSBv
cmlnaW5hbCBpc3N1ZT8KClRoYW5rcwpEYW5pZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
