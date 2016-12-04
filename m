From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 0/2] Device links documentation
Date: Sun, 4 Dec 2016 13:10:04 +0100
Message-ID: <cover.1480849144.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Silvio Fricke <silvio.fricke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, g@mail.linuxfoundation.org, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Dmitry Torokhov <dmitry.toro>
List-Id: iommu@lists.linux-foundation.org

Here's my suggestion for initial documentation on the device links
feature that's queued for 4.10 on Greg KH's driver-core-next branch.
Please let me know if you have any additions or corrections.

To read this in rendered form:
http://wunner.de/kernel-doc/core-api/device_link.html

Patch [2/2] could go in via driver-core-next, but patch [1/2] would
need to go in via docs-next (because the core-api directory doesn't
exist yet in driver-core-next).

@Jonathan Corbet:  Is core-api the right place to put this? An
alternative would be Documentation/driver-api, but unlike core-api
it contains less prose text but mostly just bare API docs gleaned
from kernel-doc.


To render the documentation oneself, the device links patches need
to be merged from driver-core-next into docs-next.  Here's a branch
which contains all the necessary bits:
https://github.com/l1k/linux/commits/device_links_docs_v1

(The build is currently broken for docs-next, one needs to remove
80211.xml from Documentation/DocBook/Makefile and for some reason
$BUILDDIR/cec.h.rst is not found on the first build, but only on
the second build.)


About half of the documentation was distilled from the mailing list
discussion initiated by Luis Rodriguez after KS/LPC:
https://lkml.org/lkml/2016/11/7/790
https://lkml.org/lkml/2016/11/7/795
https://lkml.org/lkml/2016/11/8/899

The other half is based on the first draft I posted in September:
https://lkml.org/lkml/2016/9/27/215

Thanks,

Lukas


Lukas Wunner (2):
  Documentation/core-api/device_link: Add initial documentation
  driver core: Silence device links sphinx warning

 Documentation/core-api/device_link.rst | 279 +++++++++++++++++++++++++++++++++
 Documentation/core-api/index.rst       |   8 +
 drivers/base/core.c                    |   4 +-
 include/linux/device.h                 |   1 +
 4 files changed, 290 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/core-api/device_link.rst

-- 
2.10.2
