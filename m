From: Jeffrey Hugo <jhugo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: msm8998: Add PCIe SMMU node
Date: Fri, 29 Mar 2019 13:42:37 -0600
Message-ID: <19de4919-d765-b098-8d83-458567bb03bc@codeaurora.org>
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
	<82ab78ee-4a38-4eee-f064-272b6f964f17@free.fr>
	<e7c8137a-2408-a71a-f722-199a86a75d13@free.fr>
	<5aa56120-b686-194b-36d6-8177b5749a19@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5aa56120-b686-194b-36d6-8177b5749a19-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Marc Gonzalez <marc.w.gonzalez-GANU6spQydw@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: MSM <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Manu Gautam <mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gMy8yOS8yMDE5IDEyOjI5IFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjkvMDMvMjAx
OSAxMDo1MSwgTWFyYyBHb256YWxleiB3cm90ZToKPj4gT24gMjgvMDMvMjAxOSAxODowNSwgTWFy
YyBHb256YWxleiB3cm90ZToKPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNnbG9i
YWwtaW50ZXJydXB0cyA9IDwwPjsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludGVycnVw
dHMgPQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8R0lDX1NQSSAzNjQgSVJR
X1RZUEVfRURHRV9SSVNJTkc+LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8
R0lDX1NQSSAzNjUgSVJRX1RZUEVfRURHRV9SSVNJTkc+LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCA8R0lDX1NQSSAzNjYgSVJRX1RZUEVfRURHRV9SSVNJTkc+LAo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8R0lDX1NQSSAzNjcgSVJRX1RZUEVfRURHRV9S
SVNJTkc+LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8R0lDX1NQSSAzNjgg
SVJRX1RZUEVfRURHRV9SSVNJTkc+LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCA8R0lDX1NQSSAzNjkgSVJRX1RZUEVfRURHRV9SSVNJTkc+Owo+Pj4gK8KgwqDCoMKgwqDCoMKg
IH07Cj4+PiArCj4+Cj4+IFRoZSByZXN0IG9mIHRoZSBub2RlIGxvb2tzIGZhaXJseSBzdHJhaWdo
dC1mb3J3YXJkLgo+IAo+IFlvdSBzaG91bGQgcHJvYmFibHkgaGF2ZSBzb21lICJidXMiIGFuZCAi
aWZhY2UiIGNsb2NrcyB0b28sIHBlciB0aGUgCj4gcmVxdWlyZW1lbnQgb2YgInFjb20sc21tdS12
MiIuIE1heWJlIFZpdmVrIG1pZ2h0IGtub3cgd2hhdCdzIHJlbGV2YW50IAo+IGZvciBNU004OTk4
Pwo+IAoKVGhlIGNsb2NrcyB0aGF0IHBvd2VyIHRoZSBTTU1VIGFyZSBub3QgdW5kZXIgdGhlIGNv
bnRyb2wgb2YgTGludXgsIGJ1dCAKcmF0aGVyIHRoZSBSUE0gc3Vic3lzdGVtLiAgVGhlIGludGVy
ZmFjZSB0byB0aGVtIGlzIHRoZSBpbnRlcmNvbm5lY3QgCmZyYW1ld29yaywgd2hpY2ggZG9lcyBu
b3QgeWV0IHN1cHBvcnQgODk5OCBwZXIgbXkgdW5kZXJzdGFuZGluZy4gIFRoZSAKY2xvY2tzIHdp
bGwgYWx3YXlzIGJlIG9uLCBidXQgcGVyaGFwcyBub3QgYXQgdGhlIGJlc3QgcmF0ZSBmb3IgCnBl
cmZvcm1hbmNlIHVudGlsIHRoZSBpbnRlcmNvbm5lY3QgaXMgYnJvdWdodCBpbi4KCi0tIApKZWZm
cmV5IEh1Z28KUXVhbGNvbW0gRGF0YWNlbnRlciBUZWNobm9sb2dpZXMgYXMgYW4gYWZmaWxpYXRl
IG9mIFF1YWxjb21tIApUZWNobm9sb2dpZXMsIEluYy4KUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJ
bmMuIGlzIGEgbWVtYmVyIG9mIHRoZQpDb2RlIEF1cm9yYSBGb3J1bSwgYSBMaW51eCBGb3VuZGF0
aW9uIENvbGxhYm9yYXRpdmUgUHJvamVjdC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
