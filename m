From: David Kiarie <davidkiarie4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Possible bug
Date: Fri, 6 May 2016 22:48:26 +0300
Message-ID: <CABdVeADF_cGz07noWVant4zC=be80Uwys_ndDznNG=q49FnxEg@mail.gmail.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Valentine Sinitsyn <valentine.sinitsyn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello all,

There seems to a problem with the parsing of IVMD blocks in IVRS in
linux kernel AMD IOMMU driver.

The current code seems to assume that IVHD and IVMD blocks cannot
occur on the same IVRS table. From what I can see, ends up coming up
with IVMD blocks while none are specified in IVRS hence coming up with
fake unity mappings/exclusion regions. Here is the relevant code:

    ret = init_iommu_all(ivrs_base);
    if (ret)
        goto out;

    if (amd_iommu_irq_remap)
        amd_iommu_irq_remap = check_ioapic_information();

    if (amd_iommu_irq_remap) {
        /*
         * Interrupt remapping enabled, create kmem_cache for the
         * remapping tables.
         */
        ret = -ENOMEM;
        amd_iommu_irq_cache = kmem_cache_create("irq_remap_cache",
                MAX_IRQS_PER_TABLE * sizeof(u32),
                IRQ_TABLE_ALIGNMENT,
                0, NULL);
        if (!amd_iommu_irq_cache)
            goto out;

        irq_lookup_table = (void *)__get_free_pages(
                GFP_KERNEL | __GFP_ZERO,
                get_order(rlookup_table_size));
        if (!irq_lookup_table)
            goto out;
    }

    ret = init_memory_definitions(ivrs_base);
    if (ret)
        goto out;


And in 'init_memory_definitions', it's assumed there were no IVHD
entries in the IVRS by starting to parse for IVMD entries immediately
after the end of IVRS header.

   /* iterates over all memory definitions we find in the ACPI table */
static int __init init_memory_definitions(struct acpi_table_header *table)
{
    u8 *p = (u8 *)table, *end = (u8 *)table;
    struct ivmd_header *m;

    end += table->length;
    p += IVRS_HEADER_LENGTH;

    while (p < end) {
        m = (struct ivmd_header *)p;
        if (m->flags & IVMD_FLAG_EXCL_RANGE)
            init_exclusion_range(m);
        else if (m->flags & IVMD_FLAG_UNITY_MAP)
            init_unity_map_range(m);

        p += m->length;
    }

    return 0;
}
