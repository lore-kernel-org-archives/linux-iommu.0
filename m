From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 01/16] iommu: Add DOMAIN_ATTR_SPLIT_TABLES
Date: Fri, 18 May 2018 15:34:45 -0600
Message-ID: <20180518213500.31595-2-jcrouse@codeaurora.org>
References: <20180518213500.31595-1-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180518213500.31595-1-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

QWRkIGEgbmV3IGRvbWFpbiBhdHRyaWJ1dGUgdG8gZW5hYmxlIHNwbGl0IHBhZ2V0YWJsZSBzdXBw
b3J0IGZvciBkZXZpY2VzCmRldmljZXMgdGhhdCBzdXBwb3J0IGl0LgoKU2lnbmVkLW9mZi1ieTog
Sm9yZGFuIENyb3VzZSA8amNyb3VzZUBjb2RlYXVyb3JhLm9yZz4KLS0tCiBpbmNsdWRlL2xpbnV4
L2lvbW11LmggfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvaW9tbXUuaCBiL2luY2x1ZGUvbGludXgvaW9tbXUuaAppbmRleCBk
N2UyZjU0MDg2ZTQuLjM2NjI1NGU0YjA3ZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9pb21t
dS5oCisrKyBiL2luY2x1ZGUvbGludXgvaW9tbXUuaApAQCAtMTUzLDYgKzE1Myw3IEBAIGVudW0g
aW9tbXVfYXR0ciB7CiAJRE9NQUlOX0FUVFJfRlNMX1BBTVVfRU5BQkxFLAogCURPTUFJTl9BVFRS
X0ZTTF9QQU1VVjEsCiAJRE9NQUlOX0FUVFJfTkVTVElORywJLyogdHdvIHN0YWdlcyBvZiB0cmFu
c2xhdGlvbiAqLworCURPTUFJTl9BVFRSX1NQTElUX1RBQkxFUywKIAlET01BSU5fQVRUUl9NQVgs
CiB9OwogCi0tIAoyLjE3LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkZyZWVkcmVubyBtYWlsaW5nIGxpc3QKRnJlZWRyZW5vQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Zy
ZWVkcmVubwo=
