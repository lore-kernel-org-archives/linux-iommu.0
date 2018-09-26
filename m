From: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V3] PCI: Enable PASID when End-to-End TLP is supported by
	all bridges
Date: Wed, 26 Sep 2018 13:22:09 -0400
Message-ID: <ff87c6ab-fdd2-c75d-285a-e2d19c640e2b@codeaurora.org>
References: <1530372264-20653-1-git-send-email-okaya@codeaurora.org>
	<20180926162235.GA30177@araj-mobl1.jf.intel.com>
	<e2da631e-ccbf-af94-ea0c-6c6c4d842768@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <e2da631e-ccbf-af94-ea0c-6c6c4d842768-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
To: "Raj, Ashok" <ashok.raj-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, IOMMU Mailing List <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

T24gOS8yNi8yMDE4IDE6MjAgUE0sIFNpbmFuIEtheWEgd3JvdGU6Cj4gCj4gVGhpc8KgcGF0Y2jC
oGFjdHVhbGx5wqBicm9rZcKgdGhlwqBpbnRlZ3JhdGVkwqBlbmRwb2ludHPCoGxpa2XCoHlvdcKg
d2VyZcKgbWVudGlvbmluZy4KPiBJdMKgd2FzwqBmaXhlZMKgYnnCoGHCoGZvbGxvd8KgdXDCoHBh
dGNowqBmcm9twqBudmlkaWHCoGd1eXMuCj4gCj4gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRz
L2xpbnV4L2NvbW1pdC85ZDI3ZTM5ZDMwOWM5MzAyNWFlNmFhOTcyMzZhZjE1YmVmMmE1ZjFmI2Rp
ZmYtYTdmMGFjZDcxNWU5OTFkZjVkZmI0NTBkMmI5YWJlYmMgCj4gCgpUdXJucyBvdXQgRmVsaXgg
d29ya3MgYXQgQU1ELiBBcG9sb2dpZXMgZm9yIHRoZSBuYW1lIGNvbmZ1c2lvbi4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
