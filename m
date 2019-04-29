From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/9] PCI: add help pci_dev_id
Date: Mon, 29 Apr 2019 16:14:46 -0500
Message-ID: <20190429211446.GA145057@google.com>
References: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2e1f9a57-6d08-d017-24da-3e6b97fa2449-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "open list:AMD KFD" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "open list:PCI SUBSYSTEM" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Realtek linux nic maintainers <nic_swsd-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Giuseppe Cavallaro <peppe.cavallaro-qxv4g6HH51o@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XWGXanvQGlWp@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gV2VkLCBBcHIgMjQsIDIwMTkgYXQgMDk6MTA6MjFQTSArMDIwMCwgSGVpbmVyIEthbGx3ZWl0
IHdyb3RlOgo+IEluIHNldmVyYWwgcGxhY2VzIGluIHRoZSBrZXJuZWwgd2UgZmluZCBQQ0lfREVW
SUQgdXNlZCBsaWtlIHRoaXM6Cj4gUENJX0RFVklEKGRldi0+YnVzLT5udW1iZXIsIGRldi0+ZGV2
Zm4pIFRoZXJlZm9yZSBjcmVhdGUgYSBoZWxwZXIKPiBmb3IgaXQuCj4gCj4gdjI6Cj4gLSBhcHBs
eSB0aGUgY2hhbmdlIHRvIGFsbCBhZmZlY3RlZCBwbGFjZXMgaW4gdGhlIGtlcm5lbAo+IAo+IEhl
aW5lciBLYWxsd2VpdCAoOSk6Cj4gICBQQ0k6IGFkZCBoZWxwZXIgcGNpX2Rldl9pZAo+ICAgUENJ
OiB1c2UgaGVscGVyIHBjaV9kZXZfaWQKPiAgIHI4MTY5OiB1c2UgbmV3IGhlbHBlciBwY2lfZGV2
X2lkCj4gICBwb3dlcnBjL3Bvd2VybnYvbnB1OiB1c2UgaGVscGVyIHBjaV9kZXZfaWQKPiAgIGRy
bS9hbWRrZmQ6IHVzZSBoZWxwZXIgcGNpX2Rldl9pZAo+ICAgaW9tbXUvYW1kOiB1c2UgaGVscGVy
IHBjaV9kZXZfaWQKPiAgIGlvbW11L3Z0LWQ6IHVzZSBoZWxwZXIgcGNpX2Rldl9pZAo+ICAgc3Rt
bWFjOiBwY2k6IHVzZSBoZWxwZXIgcGNpX2Rldl9pZAo+ICAgcGxhdGZvcm0vY2hyb21lOiBjaHJv
bWVvc19sYXB0b3A6IHVzZSBoZWxwZXIgcGNpX2Rldl9pZAo+IAo+ICBhcmNoL3Bvd2VycGMvcGxh
dGZvcm1zL3Bvd2VybnYvbnB1LWRtYS5jICAgICAgICAgfCAxNCArKysrKystLS0tLS0tLQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyAgICAgICAgfCAgMyArLS0K
PiAgZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIg
Ky0KPiAgZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jICAgICAgICAgICAgICAgICAgICAgIHwg
IDIgKy0KPiAgZHJpdmVycy9pb21tdS9pbnRlbF9pcnFfcmVtYXBwaW5nLmMgICAgICAgICAgICAg
IHwgIDIgKy0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OS5jICAgICAgICAg
ICAgIHwgIDMgKy0tCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1h
Y19wY2kuYyB8ICAyICstCj4gIGRyaXZlcnMvcGNpL21zaS5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICA2ICsrKy0tLQo+ICBkcml2ZXJzL3BjaS9zZWFyY2guYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAxMCArKystLS0tLS0tCj4gIGRyaXZlcnMvcGxhdGZvcm0vY2hy
b21lL2Nocm9tZW9zX2xhcHRvcC5jICAgICAgICB8ICAyICstCj4gIGluY2x1ZGUvbGludXgvcGNp
LmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA1ICsrKysrCj4gIDExIGZpbGVzIGNo
YW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQoKQXBwbGllZCB3aXRoIGFj
a3MvcmV2aWV3ZWQtYnkgZnJvbSBCZW5zb24sIEpvZXJnLCBDaHJpc3RpYW4sIEFsZXhleSwgYW5k
CkRhdmlkIHRvIHBjaS9taXNjIGZvciB2NS4yLCB0aGFua3MhCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
