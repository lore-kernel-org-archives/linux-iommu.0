From: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Subject: Re: IOAT DMA w/IOMMU
Date: Fri, 10 Aug 2018 10:24:19 -0600
Message-ID: <929f3dfa-fbff-c582-3be5-c368f11feb7e@deltatee.com>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
	<20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
	<CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
	<b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
	<95e53520-b05f-4be4-e694-463d717453a8@gigaio.com>
	<cdd9245f-eb23-9e10-1755-8f396a2cd255@deltatee.com>
	<b278c1e5-6f08-c879-a27d-7fc172645fd5@gigaio.com>
	<f04fae39-645e-3c6e-07c0-b194260bf5de@deltatee.com>
	<3f503940-db6a-ec75-ed15-1db99d5d48ef@gigaio.com>
	<112A412BB11A1242B37129D931BCE5348382CFB2@fmsmsx117.amr.corp.intel.com>
	<b8af340c-d40b-cb8c-987f-b394f1d6ec3e@gigaio.com>
	<adf51c74-36fa-b61d-8497-27bd75178ba4@deltatee.com>
	<aa9c3f41-efc9-8c68-a517-2736c8986621@gigaio.com>
	<1170c096-a749-6ee3-32d4-ebba1d12adff@gigaio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1170c096-a749-6ee3-32d4-ebba1d12adff-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>
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
To: Kit Chow <kchow-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>, "Jiang, Dave" <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eric Pilmore <epilmore-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

CgpPbiAxMC8wOC8xOCAxMDowMiBBTSwgS2l0IENob3cgd3JvdGU6Cj4gVHVybnMgb3V0IHRoZXJl
IGlzIG5vIGRtYV9tYXBfcmVzb3VyY2Ugcm91dGluZSBvbiB4ODYuIGdldF9kbWFfb3BzIAo+IHJl
dHVybnMgaW50ZWxfZG1hX29wcyB3aGljaCBoYXMgbWFwX3Jlc291cmNlIHBvaW50aW5nIHRvIE5V
TEwuCgpPaCwgeXVwLiBJIHdhc24ndCBhd2FyZSBvZiB0aGF0LiBGcm9tIGEgY3Vyc29yeSB2aWV3
LCBpdCBsb29rcyBsaWtlIGl0CnNob3VsZG4ndCBiZSB0b28gaGFyZCB0byBpbXBsZW1lbnQgdGhv
dWdoLgoKPiBXaWxsIHBva2UgYXJvdW5kIHNvbWUgaW4gdGhlIGludGVsX21hcF9wYWdlIGNvZGUg
YnV0IGNhbiB5b3UgYWN0dWFsbHkgCj4gZ2V0IGEgdmFsaWQgc3RydWN0IHBhZ2UgZm9yIGEgcGNp
IGJhciBhZGRyZXNzIChkbWFfbWFwX3NpbmdsZSBjYWxscyAKPiB2aXJ0X3RvX3BhZ2UpP8KgIElm
IG5vdCwgZG9lcyBhIG1hcF9yZXNvdXJjZSByb3V0aW5lIHRoYXQgY2FuIHByb3Blcmx5IAo+IG1h
cCBhIHBjaSBiYXIgYWRkcmVzcyBuZWVkIHRvIGJlIGltcGxlbWVudGVkPwoKWWVzLCB5b3UgY2Fu
IG5vdCBnZXQgYSBzdHJ1Y3QgcGFnZSBmb3IgYSBQQ0kgYmFyIGFkZHJlc3MgdW5sZXNzIGl0J3MK
bWFwcGVkIHdpdGggWk9ORV9ERVZJQ0UgbGlrZSBpbiBteSBwMnAgd29yay4gU28gdGhhdCB3b3Vs
ZCBleHBsYWluIHdoeQpkbWFfbWFwX3NpbmdsZSgpIGRpZG4ndCB3b3JrLgoKVGhpcyBhbGwgaW1w
bGllcyB0aGF0IG50Yl90cmFuc3BvcnQgZG9lc24ndCB3b3JrIHdpdGggRE1BIGFuZCB0aGUgSU9N
TVUKdHVybmVkIG9uLiBJJ20gbm90IHN1cmUgSSd2ZSBldmVyIHRyaWVkIHRoYXQgY29uZmlndXJh
dGlvbiBteXNlbGYgYnV0IGl0CmlzIGEgYml0IHN1cnByaXNpbmcuCgpMb2dhbgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
